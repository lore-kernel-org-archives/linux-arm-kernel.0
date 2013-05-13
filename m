From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 13 May 2013 16:59:06 +0200
Subject: Board file to device tree migration
In-Reply-To: <CAGGh5h3MC=ruocV9u6Cig=oiTtqU8GtpQ6sRKUZmUNk-C7Houw@mail.gmail.com>
References: <CAGGh5h3MC=ruocV9u6Cig=oiTtqU8GtpQ6sRKUZmUNk-C7Houw@mail.gmail.com>
Message-ID: <20130513165906.7cbcafcd@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear jean-philippe francois,

On Mon, 13 May 2013 11:44:04 +0200, jean-philippe francois wrote:

> I am maintaining a board file, which i did not submit since the board
> was developped after the decision was taken to move to device tree,
> and I figured no more board file would be accepted.
> 
> I can't move to full device tree, since if my understanding is
> correct, the omap3-isp is not supported yet, and our board is a
> camera, so isp is mandatory.
> 
> My question is, is it possible to do a mixed style init, with some of
> the devices coming from a board file, and others from a dts file ? Is
> there any example of board using this kind of mixed init ?

Yes. We do this for many Marvell Kirkwood boards. For example, in
mach-kirkwood/board-dt.c, we have:

static void __init kirkwood_dt_init(void)
{
	[...]
        if (of_machine_is_compatible("globalscale,dreamplug"))
                dreamplug_init();

        if (of_machine_is_compatible("globalscale,guruplug"))
                guruplug_dt_init();
	[...]
}

DT_MACHINE_START(KIRKWOOD_DT, "Marvell Kirkwood (Flattened Device Tree)")
	[...]
        .init_machine   = kirkwood_dt_init,
	[...]
MACHINE_END

And then dreamplug_init(), guruplug_dt_init() are in their own board
file, and register the devices for which the driver does not (yet) have
a DT binding.

OMAP doesn't seem to do this much, but if you look at
mach-omap2/board-generic.c, you'll see that it is done for some display
devices:

static void __init omap_generic_init(void)
{
        omap_sdrc_init(NULL, NULL);

        of_platform_populate(NULL, omap_dt_match_table, NULL, NULL);

        /*
         * HACK: call display setup code for selected boards to enable omapdss.
         * This will be removed when omapdss supports DT.
         */
        if (of_machine_is_compatible("ti,omap4-panda"))
                omap4_panda_display_init_of();
        else if (of_machine_is_compatible("ti,omap4-sdp"))
                omap_4430sdp_display_init_of();
}

I think having a mixed-style init is a very good thing, because it
allows a progressive and smooth migration the Device Tree, but the
reason why it is not more widespread in the OMAP world is unknown to me.

Maybe the OMAP maintainers can comment? I've Cc'ed Tony.

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
