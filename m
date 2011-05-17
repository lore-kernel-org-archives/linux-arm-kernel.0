From: dedekind1@gmail.com (Artem Bityutskiy)
Date: Tue, 17 May 2011 08:37:23 +0300
Subject: [PATCH v5 1/8] MTD: Add integrator-flash feature to physmap
In-Reply-To: <1305557977-16871-2-git-send-email-marc.zyngier@arm.com>
References: <1305557977-16871-1-git-send-email-marc.zyngier@arm.com>
	<1305557977-16871-2-git-send-email-marc.zyngier@arm.com>
Message-ID: <1305610643.2630.15.camel@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, 2011-05-16 at 15:59 +0100, Marc Zyngier wrote:
>  #ifdef CONFIG_MTD_PARTITIONS
> -static const char *part_probe_types[] = { "cmdlinepart", "RedBoot", NULL };
> +static const char *part_probe_types[] = { "cmdlinepart", "RedBoot",
> +#ifdef CONFIG_MTD_AFS_PARTS
> +					  "afs",
> +#endif
> +					  NULL };

We want to kill CONFIG_MTD_PARTITIONS:

http://www.linux-mtd.infradead.org/doc/general.html#L_partitions_ban

and Jamie Iles is doing this ATM. The reason for this is that MTD
partitions are used always everywhere anyway, and current amount of
ifdefs is scary.

I see this CONFIG_MTD_AFS_PARTS you add and I do not think it is the
right way to go. I cannot tell you now what would be exactly the right
way, but something which does not require ifdef, something where drivers
do not contain any information about partition types like "afs" or
"cmdlinepart" or whatever, something where partition types are
registered within an infrastructure and most of the stuff is hidden from
the drivers.

I think we should ban stuff like the above as well and force people to
create saner MTD partitions support.

Sorry if this sounds like an attack, it is not. I just think that we
carry crap for too long and should start forcing people to clean it up
by not accepting changes :-)

-- 
Best Regards,
Artem Bityutskiy (????? ????????)
