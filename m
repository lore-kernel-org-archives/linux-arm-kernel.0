From: sr@denx.de (Stefan Roese)
Date: Wed, 23 Mar 2016 18:25:46 +0100
Subject: [PATCH v2] spi: orion.c: Add direct access mode
In-Reply-To: <20160323132732.GN2566@sirena.org.uk>
References: <1458663893-13766-1-git-send-email-sr@denx.de>
 <20160322173546.40d24cc2@free-electrons.com> <56F17684.2010307@denx.de>
 <20160323113316.GH2566@sirena.org.uk> <56F2852C.5010006@denx.de>
 <20160323125448.GM2566@sirena.org.uk> <56F295E1.4030505@denx.de>
 <20160323132732.GN2566@sirena.org.uk>
Message-ID: <56F2D19A.7020604@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23.03.2016 14:27, Mark Brown wrote:
> On Wed, Mar 23, 2016 at 02:10:57PM +0100, Stefan Roese wrote:
>> On 23.03.2016 13:54, Mark Brown wrote:
>
>>> I haven't looked at your new code at all.  What I'm saying is that
>>> specifying a per-device MBus window seems like pointless complexity.
>
>> I don't necessarily share this opinions. Code-wise, its less complex
>> that re-configuring (removing the old and creating the new) the MBus
>> window. But I have no strong feeling here. Whatever is decided that
>> should be used, I can go with.
>
> No, really - it's just unhelpful.  Putting this in the ABI means that
> every single system integrator who cares about performance is going to
> need to go and manually figure out how to configure this in DT and
> manually select values.  That's not doing a good job for users, it's
> making their lives harder for no gain.  If there are no physical
> constraints then how we allocate space in the MBus should be a runtime
> thing, it shouldn't be part of the ABI.

Do I understand you correctly, that you want the complete MBus
allocation and configuration to be included in the SPI driver
instead of using the DT to describe the window (target, attribute,
area)? If yes, then the SPI driver would be the first driver
to do this "internally". All other drivers using MBus resources
parse these from the DT (AFAIK) as this is highly SoC specific.

Sidenote:
Please note that this direct access mode is really not suitable
for "normal" SPI devices like SPI NOR chips. As the direct read
mode (as described in chapter 22.5.1 of the Armada XP datasheet)
always generates:

a) a write command to the SPI bus (opcode configurable via register)

and

b) writes 1-4 address bytes to the SPI bus

before the data is read from the SPI bus.

So its definitely nothing that should be enabled per default for
all SPI devices. In my case of the FPGA bitstream loading, the
direct write mode is perfect, as it provides the fastest way to
stream the bitstream back-to-back onto the SPI bus.

Thanks,
Stefan
