From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Tue, 25 Aug 2015 21:43:14 +0800
Subject: [PATCH v1 3/3] arm64: dts: add Hi6220 mailbox node
In-Reply-To: <20150825104256.GB13471@leverpostej>
References: <1439977055-1747-1-git-send-email-leo.yan@linaro.org>
 <1439977055-1747-4-git-send-email-leo.yan@linaro.org>
 <20150821184059.GB2000@svinekod> <20150824091845.GA28290@leoy-linaro>
 <20150824095144.GA7139@leverpostej> <1440411596.3517.12.camel@linaro.org>
 <20150824114903.GT10728@bivouac.eciton.net>
 <1440490427.10987.29.camel@linaro.org>
 <20150825094630.GU10728@bivouac.eciton.net>
 <1440497710.10987.42.camel@linaro.org> <20150825104256.GB13471@leverpostej>
Message-ID: <1440510194.10987.52.camel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2015-08-25 at 11:42 +0100, Mark Rutland wrote:
> > > Are you then going to hack GRUB, release a special HiKey version of
> > > GRUB, not support any other versions, and still can your firmware
> > > UEFI?
> > 
> > I don't need to hack GRUB at all.
> 
> Then it is working for you by pure chance alone.
> 
> Please listen to the advice you are being given here; we're trying to
> ensure that your platform functions (and continues to function) as best
> it can.

Since we discussed a lot on this, let's make a conclusion on it.

1. UEFI could append the reserved buffer in it's memory mapping.
2. These reserved buffer must be declared in DT, since we also need to
   support non-UEFI (uboot) at the same time.
3. Mailbox node should reference reserved buffer by phandle in DT. Then
   map the buffer as non-cacheable in driver.
4. These reserved buffer must use "no-map" property since it should be
   non-cacheable in driver.
5. A patch is necessary in kernel. If efi stub feature is enabled,
   arm kernel should not parse memory node or reserved memory buffer in
   DT any more. Arm kernel should either fetch memory information from 
   efi or DT. Currently arm kernel fetch both efi memory information and
   reserved buffer from DTB at the same time.

Do you agree on these points?

Regards
Haojian
