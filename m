From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Mon, 06 Jan 2014 10:09:19 +0100
Subject: [PATCH v2 2/2] i2c: mv64xxx: Fix bus hang on A0 version of the
 Armada XP SoCs
In-Reply-To: <201401051533.58931.arnd@arndb.de>
References: <1388743185-24822-1-git-send-email-gregory.clement@free-electrons.com>
 <1388743185-24822-3-git-send-email-gregory.clement@free-electrons.com>
 <201401051533.58931.arnd@arndb.de>
Message-ID: <52CA72BF.10604@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On 05/01/2014 15:33, Arnd Bergmann wrote:
> On Friday 03 January 2014, Gregory CLEMENT wrote:
>> The first variants of Armada XP SoCs (A0 stepping) have issues related
>> to the i2c controller which prevent to use the offload mechanism and
>> lead to a kernel hang during boot.
>>
>> The driver now check the revision of the SoC. If the revision is not
>> more recent than the A0 or if the driver can't get the SoC revision
>> then it disables the offload mechanism.
>>
>> Cc: stable at vger.kernel.org
>> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
>> Acked-by: Wolfram Sang <wsa@the-dreams.de>
> 
> Relying on the soc id patch for a "stable" bug fix seems a little
> far-reaching to me. I would be happier to first try to do a local
> detection based on the i2c bus device node itself. Do you know how

It was my first proposal in case adding the soc id detection was
a too big things. But it turned out that the amount of code is very
low so I really think it worth adding it along the fix. Device tree
is supposed to be stable so as soon as we add something in it we are
supposed support it forever. Moreover using device tree for something
we can probe is counter productive.

> common the A0 revision is? You mention "early release of the
> OpenBlocks AX3-4 boards". Any others that you suspect? If not,

No, from the info I gathered I expected that only OpenBlocks AX3-4
would be the only product shipped with an A0 version and as I said
it should be only a limit amount of them.

> how about adding either a boolean property in the node or a
> new "compatible" value to distinguish the working version from
> the broken one?
> 
> If A0 is very common, you might do the same thing in the opposite
> way and default to "broken" unless it is explicitly known to be
> the good version. In general, I'm much in favor of keeping "quirks"
> local to device drivers if possible and not rely on global system
> state.
> 
> 	Arnd
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
