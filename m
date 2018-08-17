From: daniel@iogearbox.net (Daniel Borkmann)
Date: Fri, 17 Aug 2018 20:30:16 +0200
Subject: [offlist] Re: Crash in netlink/sk_filter_trim_cap on ARMv7 on
 4.18rc1
In-Reply-To: <20180817161743.GX30658@n2100.armlinux.org.uk>
References: <CALeDE9PP__kPHX_aW24kwzGf9BgA0gQOQJSY+Qw0yFMOLn4Pcw@mail.gmail.com>
 <7ff516fd-1d01-4d7a-1d5d-b58932c0c69d@gmail.com>
 <CALeDE9Nkz+cbueruiez_43ZS1ebAiQHDaVZRARE8raypYz323A@mail.gmail.com>
 <ad98d60c-bd60-b495-c4bd-507fc29c8bcd@iogearbox.net>
 <CALeDE9PBZWJBp8KB0mB4zoNXqscmzxWzz+LnuqRA-z4t1e9T8g@mail.gmail.com>
 <CALeDE9OOrZUnaNpzkYPU30iN=4HFQaqEomjf14EO5EtcnHu8OQ@mail.gmail.com>
 <20180816203515.GA7688@torres.zugschlus.de>
 <20180816225844.GW30658@n2100.armlinux.org.uk>
 <CALeDE9Pm7nsqDFL0m0ZsNdnEti6YAbEPhtfbNMPe=UZCUyyHMA@mail.gmail.com>
 <1c2218cb-63bf-1528-6156-8ce93f46169c@iogearbox.net>
 <20180817161743.GX30658@n2100.armlinux.org.uk>
Message-ID: <adf49ea9-09a3-80f8-8c85-a62d028e21a3@iogearbox.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/17/2018 06:17 PM, Russell King - ARM Linux wrote:
> On Fri, Aug 17, 2018 at 02:40:19PM +0200, Daniel Borkmann wrote:
>> I'd have one potential bug suspicion, for the 4.18 one you were trying,
>> could you run with the below patch to see whether it would help?
> 
> I think this is almost certainly the problem - looking at the history,
> it seems that the "-4" was assumed to be part of the scratch stuff in
> commit 38ca93060163 ("bpf, arm32: save 4 bytes of unneeded stack space")
> but it isn't - it's because "off" of zero refers to the top word in the
> stack (iow at STACK_SIZE-4).

Yeah agree, my thinking as well (albeit bit late, sigh, sorry about that).
Waiting for Peter to get back with results for definite confirmation. Your
rework in 1c35ba122d4a ("ARM: net: bpf: use negative numbers for stacked
registers") and 96cced4e774a ("ARM: net: bpf: access eBPF scratch space using
ARM FP register") fixes this in mainline, so unless I'm missing something this
would only need a stand-alone fix for 4.18/stable which I can cook up and
submit then.

Thanks,
Daniel
