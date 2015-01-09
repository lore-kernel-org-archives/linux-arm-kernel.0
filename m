From: Yalin.Wang@sonymobile.com (Wang, Yalin)
Date: Fri, 9 Jan 2015 10:16:32 +0800
Subject: [RFC V6 2/3] arm:add bitrev.h file to support rbit instruction
In-Reply-To: <20150108184059.GZ12302@n2100.arm.linux.org.uk>
References: <20141030120127.GC32589@arm.com>
 <CAKv+Gu9g5Q6fjPUy+P8YxkeDrH+bdO4kKGnxTQZRFhQpgPxaPA@mail.gmail.com>
 <20141030135749.GE32589@arm.com>
 <35FD53F367049845BC99AC72306C23D103E010D18272@CNBJMBX05.corpusers.net>
 <35FD53F367049845BC99AC72306C23D103E010D18273@CNBJMBX05.corpusers.net>
 <35FD53F367049845BC99AC72306C23D103E010D18275@CNBJMBX05.corpusers.net>
 <20141113235322.GC4042@n2100.arm.linux.org.uk>
 <35FD53F367049845BC99AC72306C23D103E010D1829B@CNBJMBX05.corpusers.net>
 <20141114095812.GG4042@n2100.arm.linux.org.uk>
 <35FD53F367049845BC99AC72306C23D103E688B313C6@CNBJMBX05.corpusers.net>
 <20150108184059.GZ12302@n2100.arm.linux.org.uk>
Message-ID: <35FD53F367049845BC99AC72306C23D103EDAF89E195@CNBJMBX05.corpusers.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Russell King - ARM Linux [mailto:linux at arm.linux.org.uk]
> Sent: Friday, January 09, 2015 2:41 AM
> To: Wang, Yalin
> Cc: 'Will Deacon'; 'Ard Biesheuvel'; 'linux-kernel at vger.kernel.org';
> 'akinobu.mita at gmail.com'; 'linux-mm at kvack.org'; 'Joe Perches'; 'linux-arm-
> kernel at lists.infradead.org'
> Subject: Re: [RFC V6 2/3] arm:add bitrev.h file to support rbit instruction
> 
> On Mon, Nov 17, 2014 at 10:38:58AM +0800, Wang, Yalin wrote:
> > Joe has submitted patches to maintainers, So we need wait for them to
> > be accepted .
> 
> I ran these patches through my autobuilder, and while most builds didn't
> seem to be a problem, the randconfigs found errors:
> 
> /tmp/ccbiuDjS.s:137: Error: selected processor does not support ARM mode
> `rbit r3,r2'
> /tmp/ccbiuDjS.s:145: Error: selected processor does not support ARM mode
> `rbit r0,r1'
> make[4]: *** [drivers/iio/amplifiers/ad8366.o] Error 1
> 
> /tmp/ccFhnoO3.s:6789: Error: selected processor does not support ARM mode
> `rbit r2,r2'
> make[4]: *** [drivers/mtd/devices/docg3.o] Error 1
> 
> /tmp/cckMf2pp.s:239: Error: selected processor does not support ARM mode
> `rbit ip,ip'
> /tmp/cckMf2pp.s:241: Error: selected processor does not support ARM mode
> `rbit r2,r2'
> /tmp/cckMf2pp.s:248: Error: selected processor does not support ARM mode
> `rbit lr,lr'
> /tmp/cckMf2pp.s:250: Error: selected processor does not support ARM mode
> `rbit r3,r3'
> make[5]: *** [drivers/video/fbdev/nvidia/nvidia.o] Error 1
> 
> /tmp/ccTgULsO.s:1151: Error: selected processor does not support ARM mode
> `rbit r1,r1'
> /tmp/ccTgULsO.s:1158: Error: selected processor does not support ARM mode
> `rbit r0,r0'
> /tmp/ccTgULsO.s:1164: Error: selected processor does not support ARM mode
> `rbit ip,ip'
> /tmp/ccTgULsO.s:1166: Error: selected processor does not support ARM mode
> `rbit r3,r3'
> /tmp/ccTgULsO.s:1227: Error: selected processor does not support ARM mode
> `rbit r5,r5'
> /tmp/ccTgULsO.s:1229: Error: selected processor does not support ARM mode
> `rbit lr,lr'
> /tmp/ccTgULsO.s:1236: Error: selected processor does not support ARM mode
> `rbit r0,r0'
> /tmp/ccTgULsO.s:1238: Error: selected processor does not support ARM mode
> `rbit r3,r3'
> make[5]: *** [drivers/video/fbdev/nvidia/nv_accel.o] Error 1
> 
> The root cause is that the kernel being built is supposed to support both
> ARMv7 and ARMv6K CPUs.  However, "rbit" is only available on
> ARMv6T2 (thumb2) and ARMv7, and not plain ARMv6 or ARMv6K CPUs.
> 
In the patch that you applied:
8205/1 	add bitrev.h file to support rbit instruction

I have add :
+	select HAVE_ARCH_BITREVERSE if ((CPU_V7M || CPU_V7) && !CPU_V6)

If you build kernel support ARMv6K, should CONFIG_CPU_V6=y, isn't it ?
Then will not build hardware rbit instruction, isn't it ?

Thanks
