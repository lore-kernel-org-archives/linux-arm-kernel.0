From: sebastian@breakpoint.cc (Sebastian Andrzej Siewior)
Date: Fri, 26 Oct 2012 10:02:54 +0200
Subject: [PATCH v2 2/2] USB: doc: Binding document for ehci-platform driver
In-Reply-To: <Pine.LNX.4.44L0.1210251035270.1278-100000@iolanthe.rowland.org>
References: <20121025102301.GA3469@breakpoint.cc>
 <Pine.LNX.4.44L0.1210251035270.1278-100000@iolanthe.rowland.org>
Message-ID: <20121026080254.GD3009@breakpoint.cc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 25, 2012 at 10:36:14AM -0400, Alan Stern wrote:
> What happens if the drivers get probed in the wrong order?  That is, if 
> ehci-platform gets probed before ehci-spear (or whatever)?

The "wrong" driver may get loaded. Right now, you should have them all in
one driver. For instance the crypto node in mpc8315erdb.dts:
|   crypto at 30000 {
|           compatible = "fsl,sec3.3", "fsl,sec3.1", "fsl,sec3.0",
|                        "fsl,sec2.4", "fsl,sec2.2", "fsl,sec2.1",
|                        "fsl,sec2.0";
?

The higher the version, the more features are available by the hardware.
The driver [0] probes only for "fsl,sec2.0" but it uses
of_device_is_compatible() to check for the other entries. You could also add
all 7 compatible entries to the driver and distinguish them by the driver_data
field. This is an implementation detail.
However, having two drivers, one for "fsl,sec3.3" and one for "fsl,sec2.0",
would "randomly" load one of the two driver depending on link order and so on.

[0] drivers/crypto/talitos.c

> 
> Alan Stern
> 

Sebastian
