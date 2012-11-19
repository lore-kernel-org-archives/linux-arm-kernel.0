From: srinivas.kandagatla@st.com (Srinivas KANDAGATLA)
Date: Mon, 19 Nov 2012 12:07:57 +0000
Subject: [RFC PATCH 3.7.0-rc4] ARM:smp: introduce smp_notify_cpu_stop
 to fix kexec smp case
In-Reply-To: <20121119105848.GF3205@mudshark.cambridge.arm.com>
References: <1353003478-22291-1-git-send-email-srinivas.kandagatla@st.com>
 <20121115211833.GD13998@mudshark.cambridge.arm.com> <50A5FBB7.9040001@st.com>
 <20121119105848.GF3205@mudshark.cambridge.arm.com>
Message-ID: <50AA211D.20005@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19/11/12 10:58, Will Deacon wrote:
> On Fri, Nov 16, 2012 at 08:39:19AM +0000, Srinivas KANDAGATLA wrote:
>> On 15/11/12 21:18, Will Deacon wrote:
>>>  The bigger issue is co-ordinating with the
>>> secondaries so you know when they're safely out of the way and you can
>>> proceed with the kexec. Remember that you won't have working locks and you
>>> can't cross-call a function because it won't actually return.
>> Yes I agree and understand the limitation.
>> The callback should simple and just relocate the secondary core to a
>> safe place which in our case is a holding pen, which is safe and not in
>> the system ram.
>> After the callback, the secondary core will be spinning in the holding
>> pen which will be released once they get a matching cpu-id.
>> And this approach works perfectly ok on our chips and I guess should
>> work for other chips aswell.
> But how do you know when the callback is complete? That's the part that is
> tricky as you need to avoid clobbering the kernel image before you know for
> sure that all the secondaries are out of the way.
Yes, there is a very small window of opportunity for the primary core to
continue with new kernel image.

We have two options here:

1> I think the existing infrastructure of cpu_kill can be re-used to
know if the callback is complete and is very much specific to platform
implementation.
2> Add a is_cpu_stopped() in smp_operations and call it from primary
core with cpu set to secondary cores, similar to smp_kill_cpus call.
This is also specific to platform implementation.

Both of them will address the concern.
???


>  I think you either need
> some horrible homebrew locking primitives or something in hardware to signal
> back to the primary CPU.
>
>>> If you can solve the synchronisation problem then we can think about adding
>>> these hooks.
>> I think the call back code should not do anything complex other than few
>> lines of assembly or jump to a holding pen, this way it does not need
>> any synchronization calls or system infrastructure.
> See above.
>
> Will
