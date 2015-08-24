From: leif.lindholm@linaro.org (Leif Lindholm)
Date: Mon, 24 Aug 2015 12:49:03 +0100
Subject: [PATCH v1 3/3] arm64: dts: add Hi6220 mailbox node
In-Reply-To: <1440411596.3517.12.camel@linaro.org>
References: <1439977055-1747-1-git-send-email-leo.yan@linaro.org>
 <1439977055-1747-4-git-send-email-leo.yan@linaro.org>
 <20150821184059.GB2000@svinekod>
 <20150824091845.GA28290@leoy-linaro>
 <20150824095144.GA7139@leverpostej>
 <1440411596.3517.12.camel@linaro.org>
Message-ID: <20150824114903.GT10728@bivouac.eciton.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 24, 2015 at 06:19:56PM +0800, Haojian Zhuang wrote:
> > If your EFI memory map describes the memory as mappable, it is wrong.
> 
> When kernel is working, kernel will create its own page table based on
> UEFI memory map. Since it's reserved in DTS file as Leo's patch, it'll
> be moved to reserved memblock. Why is it wrong?
> 
> In the second, UEFI is firmware. When it's stable, nobody should change
> it without any reason.

Much like the memory map.

> These reserved memory are used in mailbox driver.
> Look. It's driver, so it could be changed at any time.

No, it is a set of regions of memory set aside for use by a different
master in the system as well as communications with that master.

The fact that there is a driver somewhere that is aware of this is
entirely beside the point. All agents in the system must adher to this
protocol.

> Why do you want
> to UEFI knowing this memory range? Do you hope UEFI to change when
> mailbox driver is changed?

Yes.

UEFI is a runtime environment. Having random magic areas not to be
touched will cause random pieces of software running under it to break
horribly or break other things horribly.
Unless you mark them as reserved in the UEFI memory map.
At which point the Linux kernel will automatically ignore them, and
the proposed patch is redundant.

So, yes, if you want a system that can boot reliably, run testsuites
(like SCT or FWTS), run applications (like fastboot ... or the EFI
stub kernel itself), then any memory regions that is reserved for
mailbox communication (or other masters in the system) _must_ be
marked in the EFI memory map.

/
    Leif
