From: pawel.moll@arm.com (Pawel Moll)
Date: Fri, 01 Aug 2014 18:21:14 +0100
Subject: [PATCH 5/5] platform: Make platform_bus device a platform device
In-Reply-To: <20140726201240.GB21870@kroah.com>
References: <1406298233-27876-1-git-send-email-pawel.moll@arm.com>
 <1406298233-27876-5-git-send-email-pawel.moll@arm.com>
 <20140726201240.GB21870@kroah.com>
Message-ID: <1406913674.22529.45.camel@hornet>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 2014-07-26 at 21:12 +0100, Greg Kroah-Hartman wrote:
> On Fri, Jul 25, 2014 at 03:23:53PM +0100, Pawel Moll wrote:
> > ... describing the root of the device tree, so one can write
> > a platform driver initializing the platform.
> 
> Wait, what do you mean by "one can write a platform driver initializing
> the platform"?  I don't understand your end goal here...

Bad wording, sorry. The goal is to have a platform driver (as in
platform bus) that will initialize my platform (as in: board, machine,
hardware). My platform (as in: the board) will be represented by the
root platform bus device (as in: the bus ;-) with compatible value
matching the one passed in the device tree's root.

The tree:

8<----------------------------
/ {
	compatible = "my,board";
}
8<----------------------------

The driver:

8<----------------------------
static struct of_device_id my_board_match[] = {
        { .compatible = "my,board", },
        {},
};

static struct platform_driver my_board_driver = {
        .driver = {
                .name = "my_board",
                .owner = THIS_MODULE,
                .of_match_table = of_match_ptr(my_board_match),
        },
        .probe = my_board_probe,
        .remove = my_board_remove,
};
module_platform_driver(my_board_driver);
8<----------------------------

I'll work on better commit message for the next spin.

Pawe?
