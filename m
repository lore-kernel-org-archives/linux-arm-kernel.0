From: dwmw2@infradead.org (David Woodhouse)
Date: Fri, 17 Mar 2017 20:03:11 +0000
Subject: [PATCH v33 00/14] add kdump support
In-Reply-To: <372d44fe-2d78-596a-55c6-307cb36d60a2@arm.com>
References: <20170315095656.24992-1-takahiro.akashi@linaro.org>
 <1489750991.17202.40.camel@infradead.org>
 <1489759373.17202.44.camel@infradead.org>
 <20170317153358.GI5940@leverpostej>
 <1489765628.17202.59.camel@infradead.org>
 <20170317162421.GK5940@leverpostej>
 <e75aaa3f-0d87-2523-d7d7-cef56e5bd480@arm.com>
 <372d44fe-2d78-596a-55c6-307cb36d60a2@arm.com>
Message-ID: <1489780991.17202.70.camel@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2017-03-17 at 17:10 +0000, Marc Zyngier wrote:
> 
> > > > 
> > > > FWIW if I trigger a crash on CPU 1 my kdump (still 4.9.8+v32) doesn't work.
> > > > I end up booting the kdump kernel on CPU#1 and then it gets distinctly unhappy...
> > > > 
> > > > [????0.000000] Booting Linux on physical CPU 0x1
> > > > ...
> > > > [????0.017125] Detected PIPT I-cache on CPU1
> > > > [????0.017138] GICv3: CPU1: found redistributor 0 region 0:0x00000000f0280000
> > > > [????0.017147] CPU1: Booted secondary processor [411fd073]
> > > > [????0.017339] Detected PIPT I-cache on CPU2
> > > > [????0.017347] GICv3: CPU2: found redistributor 2 region 0:0x00000000f02c0000
> > > > [????0.017354] CPU2: Booted secondary processor [411fd073]
> > > > [????0.017537] Detected PIPT I-cache on CPU3
> > > > [????0.017545] GICv3: CPU3: found redistributor 3 region 0:0x00000000f02e0000
> > > > [????0.017551] CPU3: Booted secondary processor [411fd073]
> > > > [????0.017576] Brought up 4 CPUs
> > > > [????0.017587] SMP: Total of 4 processors activated.
> > > > ...
> > > > [???31.745809] INFO: rcu_sched detected stalls on CPUs/tasks:
> > > > [???31.751299]?	1-...: (30 GPs behind) idle=c90/0/0 softirq=0/0 fqs=0?
> > > > [???31.757557]?	2-...: (30 GPs behind) idle=608/0/0 softirq=0/0 fqs=0?
> > > > [???31.763814]?	3-...: (30 GPs behind) idle=604/0/0 softirq=0/0 fqs=0?
> > > > [???31.770069]?	(detected by 0, t=5252 jiffies, g=-270, c=-271, q=0)
> > > > [???31.776161] Task dump for CPU 1:
> > > > [???31.779381] swapper/1???????R??running task????????0?????0??????1 0x00000080
> > > > [???31.786446] Task dump for CPU 2:
> > > > [???31.789666] swapper/2???????R??running task????????0?????0??????1 0x00000080
> > > > [???31.796725] Task dump for CPU 3:
> > > > [???31.799945] swapper/3???????R??running task????????0?????0??????1 0x00000080
> > > > 
> > > > Is some of that platform-specific?
> > > That sounds like timer interrupts aren't being taken.
> > > 
> > > Given that the CPUs have come up, my suspicion would be that the GIC's
> > > been left in some odd state, that the kdump kernel hasn't managed to
> > > recover from.
> > > 
> > > Marc may have an idea.
> > I thought kdump was UP only? Anyway, this doesn't look too good.
> > 
> > It would be interesting to find out whether we're still taking
> > interrupts. Also, being able to reproduce this on mainline would be useful.
> > 
> > I wonder if we don't have a bug when booting on something other than
> > CPU#0, possibly on a GICv3 platform... I'll give it a go.
> Went ahead and tried a couple of kexecs with various CPUs disabled in
> order to force kexec not to boot on CPU#0, and the VM did boot just fine.
> 
> So I'd really appreciate a mainline reproducer.

I booted an up-to-date 4.11-rc2 kernel with the v33 patch set. I cannot
reproduce.

But then again, I can't reproduce it on 4.9 *either* any more. And that
is precisely the same kernel image I uploaded earlier. So it appears to
be sporadic, and just *happened* to hit me the first time I tried...
which is probably just as well or I'd never have tried that again :)

I'll keep trying.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: smime.p7s
Type: application/x-pkcs7-signature
Size: 4938 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170317/a232a3dc/attachment-0001.bin>
