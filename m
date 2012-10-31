From: jean.pihet@newoldbits.com (Jean Pihet)
Date: Wed, 31 Oct 2012 04:34:21 -0400
Subject: OMAP baseline test results for v3.7-rc1
In-Reply-To: <alpine.DEB.2.00.1210301400100.12697@utopia.booyaka.com>
References: <CAORVsuWFzH3UmXCaY=iqmYsE72KOecLo40tG9BcTUBirJQ5iLA@mail.gmail.com>
 <alpine.DEB.2.00.1210231918500.27211@utopia.booyaka.com>
 <CAORVsuV9_4oc6+voEM9PkqzkXKHipor5XJqaXfDNxAWLofXcxg@mail.gmail.com>
 <20121025101212.GD21217@arwen.pp.htv.fi>
 <20121026201539.GD29548@arwen.pp.htv.fi>
 <alpine.DEB.2.00.1210262201500.11258@utopia.booyaka.com>
 <20121029200032.GD30152@arwen.pp.htv.fi>
 <alpine.DEB.2.00.1210301216330.12697@utopia.booyaka.com>
 <20121030123254.GD29095@arwen.pp.htv.fi>
 <alpine.DEB.2.00.1210301239310.12697@utopia.booyaka.com>
 <20121030125419.GG29095@arwen.pp.htv.fi>
 <alpine.DEB.2.00.1210301313190.12697@utopia.booyaka.com>
 <alpine.DEB.2.00.1210301400100.12697@utopia.booyaka.com>
Message-ID: <CAORVsuX_8ryT7jmPWoQ+Lb1ztmQC-E59j64Qt1hzvsEkQ7=w+g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Paul,

- Added Rafael for the PM QoS discussion -

On Tue, Oct 30, 2012 at 10:04 AM, Paul Walmsley <paul@pwsan.com> wrote:
> On Tue, 30 Oct 2012, Paul Walmsley wrote:
>
>> Based on a very quick look, I'd say the original patch 3db11fe is broken.
>> I don't see how it can ensure that its PM_QOS_CPU_DMA_LATENCY request is
>> honored when CONFIG_CPU_IDLE=n. CONFIG_CPU_IDLE=n is the default for
>> omap2plus_defconfig.
>
> So in fact to follow up on this, looks like one of two changes are needed:
>
> 1. Revert 3db11fe
>
> or
>
> 2. If CONFIG_CPU_IDLE=n, the driver needs to call disable_hlt() in place
> of the pm_qos constraint add, and call enable_hlt() in place of the pm_qos
> constraint remove.
I do not think this is correct. Using disable_hlt is a too radical
solution and will prevent the idle completely, this is not what we
want.

Rafael, what do you think?

Furthermore without the patch 3db11fe enable_hlt and disable_hlt are
not used in the driver so this change is not the real fix for the
issue. To me the cause is somewhere else. I was hoping Felipe's
ordering fix would do it...

>
> Jean, could you please pick a solution and send a patch for the 3.7-rc
> timeframe, to fix the bug in 3db11fe?
> ?
Let me try to reproduce the issue and hopefully investigate a bit more.
Feel free to revert the patch if you feel like it is the thing to do.

>
> - Paul

Jean
