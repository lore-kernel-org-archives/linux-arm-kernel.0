From: andrew@lunn.ch (Andrew Lunn)
Date: Thu, 6 Nov 2014 15:49:50 +0100
Subject: [RFC PATCH] ARM: mvebu: Let the device-tree determine smp_ops
In-Reply-To: <1415249396-2985-1-git-send-email-chris.packham@alliedtelesis.co.nz>
References: <1415249396-2985-1-git-send-email-chris.packham@alliedtelesis.co.nz>
Message-ID: <20141106144950.GA4974@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 06, 2014 at 05:49:56PM +1300, Chris Packham wrote:
> The machine specific SMP operations can be configured either via
> setup_arch or via arm_dt_init_cpu_maps. For the ARMADA_370_XP_DT devices
> both of these are called and setup_arch wins because it is called last.
> This means that it is not possible to substitute a different set of SMP
> operations via the device-tree.
> 
> All of the ARMADA_370_XP_DT compatible devices are either single core or
> declare an enable-method in the dts (via one of armada-xp-mv78230.dtsi,
> armada-xp-mv78260.dtsi or armada-xp-mv78460.dtsi). Remove the smp
> assignment from board-v7.c so that the SMP operations set via the
> device-tree aren't discarded.
> 
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> ---
> Hi,
> 
> (This is the first patch I've sent to the arm-lkml so beware of my newbie-ness)

Hi Chris

Congratulations on a good looking patch. Nice changelog, has a
signed-off-by, comments are bellow the ---. All good.

It is however a good idea to Cc: the mvebu maintainers. I added a few
people to Cc:.

> I'm working on a new board that uses a integrated CPU that according to the
> vendor is "based on the ARMADA-XP", more on that to come in the future
> hopefully. 

A packet processor chip with an embedded CPU? Next generation
Prestera?  No need to answer that if you don't want to.

> For the most part things just work if I use a .dts based on the
> mv78260.
 
> This is my attempt at fixing the problem by not setting mdesc.smp for the
> ARMADA_370_XP_DT machines thus preventing setup_arch from overriding what has
> been setup by arm_dt_init_cpu_maps.

You really need Thomas or Gregory to Ack this patch, but to me it
looks correct.  Interestingly, this machine descriptor is used by 370,
which is a single processor. The smp operations are useless, so your
patch is also partly a cleanup.

     Andrew
