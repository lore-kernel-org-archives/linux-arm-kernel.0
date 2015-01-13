From: daniel.thompson@linaro.org (Daniel Thompson)
Date: Tue, 13 Jan 2015 10:36:29 +0000
Subject: [PATCH 3.19-rc2 v13 4/5] ARM: Add support for on-demand backtrace
 of other CPUs
In-Reply-To: <20150111183700.55ea2434@gandalf.local.home>
References: <1415968543-29469-1-git-send-email-daniel.thompson@linaro.org>	<1420469699-25350-1-git-send-email-daniel.thompson@linaro.org>	<1420469699-25350-5-git-send-email-daniel.thompson@linaro.org>	<20150105101925.64e8ecec@gandalf.local.home>	<20150109164801.GW12302@n2100.arm.linux.org.uk>
 <20150111183700.55ea2434@gandalf.local.home>
Message-ID: <54B4F52D.8010403@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/01/15 23:37, Steven Rostedt wrote:
> On Fri, 9 Jan 2015 16:48:01 +0000
> Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:
> 
>> On Mon, Jan 05, 2015 at 10:19:25AM -0500, Steven Rostedt wrote:
>>> On Mon,  5 Jan 2015 14:54:58 +0000
>>> Daniel Thompson <daniel.thompson@linaro.org> wrote:
>>>> +/* For reliability, we're prepared to waste bits here. */
>>>> +static DECLARE_BITMAP(backtrace_mask, NR_CPUS) __read_mostly;
>>>> +static  cpumask_t printtrace_mask;
>>>> +
>>>> +#define NMI_BUF_SIZE		4096
>>>> +
>>>> +struct nmi_seq_buf {
>>>> +	unsigned char		buffer[NMI_BUF_SIZE];
>>>> +	struct seq_buf		seq;
>>>> +};
>>
>> Am I missing something or does this limit us to 4096 characters of
>> backtrace output per CPU?
>>
>>> This is the same code as in x86. I wonder if we should move the
>>> duplicate code into kernel/printk/ and have it compiled if the arch
>>> requests it (CONFIG_ARCH_WANT_NMI_PRINTK or something). That way we
>>> don't have 20 copies of the same nmi_vprintk() and later find that we
>>> need to change it, and have to change it in 20 different archs.
>>
>> Agreed, though I wonder about the buffer size.
>>
> 
> Have we had kernel back traces bigger than that? Since the stack size
> is limited to page size, it would seem dangerous if backtraces filled
> up a page size itself, as most function frames are bigger than the
> typical 60 bytes of data per line.
> 
> We could change that hard coded 4096 to PAGE_SIZE, for those archs with
> bigger pages.

I've just updated the patchset with a couple of patches to common up the
printk code between arm and x86.

Just for the record I haven't changed the hard coded 4096 as part of
this. I'd be quite happy to but I didn't want to introduce any "secret"
changes to the code whilst the patch header claims I am just copying stuff.


Daniel.

> Also, if the backtrace were to fill up that much. Most the pertinent
> data from a back trace is at the beginning of the trace. Seldom do we
> care about the top most callers (bottom of the output).
> 
> -- Steve
> 
