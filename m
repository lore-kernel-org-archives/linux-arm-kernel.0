From: labath@google.com (Pavel Labath)
Date: Fri, 7 Jul 2017 14:11:49 +0100
Subject: [arm/hw_breakpoint] Detecting that hardware watchpoint support is
 unavailable
In-Reply-To: <20170707124332.GF6735@arm.com>
References: <CAJt8pk8f3Z4O=JLB8vSimAbwaAd8AqELKWJzZJF+io13Ziia6g@mail.gmail.com>
 <20170707124332.GF6735@arm.com>
Message-ID: <CAJt8pk9xh3ZzEO6Uv2V32MEw-ibgTX5Y9P8PGPYf2pYEWhePrg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 7 July 2017 at 13:43, Will Deacon <will.deacon@arm.com> wrote:
> On Fri, Jul 07, 2017 at 01:37:53PM +0100, Pavel Labath wrote:
>> Hello Pratyush, Will,
>>
>> I have an arm(32) chip, which has hardware debug support disabled, as
>> far as I can tell (DBGDSCR.MDBGen reads as zero even after explicitly
>> setting in).
>>
>> The current behavior of the kernel on these chips is to return a
>> non-zero number for the "number of supported watchpoint resources"
>> when queried with ptrace and then fail at runtime (ENODEV) when the
>> tracer attempts to set this breakpoint.
>>
>> This does not seem like a particularly nice api, and I believe it
>> would be better to just return zero for the watchpoint count
>> initially, as we already know that setting the watchpoints will fail.
>>
>> arch_hw_breakpoint_init() zeroes out the core_num_wrps when it detects
>> that debug support is not present, however when we return resource
>> info (ptrace_get_hbp_resource_info), we go through
>> hw_breakpoint_slots(), which does not read these.
>>
>> I think having ptrace_get_hbp_resource_info() read core_num_wrps would
>> be more consistent because that's how we read maximum watchpoint
>> length (arch_get_max_wp_len), which means we (correctly ?) return 0
>> when hardware debug is not supported. In fact, that is how I presently
>> detect that hardware debug is not supported (reading max_wp_len), but
>> at this moment that seems more like an accident than a deliberate
>> interface. Having num_wrps, num_brps zeroed out as well would make it
>> clear that this is how it's intended to be used.
>>
>> So, what do you think about a patch like that?
>

Fair enough. I am going to read this as "good idea in general, but I
object to the implementation".

> I don't want to expose hw_breakpoint internals to ptrace as long as we
> go through the internal perf interface. The two options really are:

I have to point out that the two of them are already connected via the
arch_get_debug_arch() and arch_get_max_wp_len() functions, both of
which are solely called from ptrace_get_hbp_resource_info(). However,
I understand that we don't want to add more stuff there if this is not
the direction we want to be going in.

>
>   1. Rip out the perf crap and integrate ptrace more tightly with
>      hw_breakpoint.

I am afraid this may be a bit above my skill level here. I am fairly
new to the kernel end of the ptrace interface. Could you elaborate on
what exactly would this entail? E.g. can this be done solely within
arm code, or would it require changing general kernel interfaces (I
fear yes).

>
>   2. Fix hw_breakpoint_slots(...) to do what you want, although I seem
>      to recall a chicken-and-egg problem there where perf insists on calling
>      that function (hw_breakpoint_slots) early.

Yeah, there is a call in init_hw_breakpoint(), which looks fairly hard to avoid.
