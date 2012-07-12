From: w.sang@pengutronix.de (Wolfram Sang)
Date: Thu, 12 Jul 2012 14:22:08 +0200
Subject: [PATCHv11 6/6] i2c: omap: Recover from Bus Busy condition
In-Reply-To: <1340896292-12112-7-git-send-email-shubhrajyoti@ti.com>
References: <1340896292-12112-1-git-send-email-shubhrajyoti@ti.com>
 <1340896292-12112-7-git-send-email-shubhrajyoti@ti.com>
Message-ID: <20120712122208.GF2194@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 28, 2012 at 08:41:32PM +0530, Shubhrajyoti D wrote:
> From: Vikram Pandita <vikram.pandita@ti.com>
> 
> In case a peripheral is driving SDA bus low (ie. a start condition), provide
> a constant clock output using the test mode of the OMAP I2C controller to
> try and clear the bus. Soft reset I2C controller after attempting the bus clear
> to ensure that controller is in a good state.
> 
> Based upon Vikram Pandita's patch from TI Android 3.0.
> I acknowledge the contributions and suggestions of Jon and Hemant.
> 
> A couple differences from the original patch ...
> 1. Add a new function for bus clear
> 2. Ensure that the CON.I2C_EN bit is set when using the SYSTEST feature to
>    output a permanent clock. This bit needs to be set and typically it would
>    be set by the unidle function but this is not the case for all OMAP
>    generations.
> 3. Program the SYSTEST setting only the bits we care about. However, restore
>    SYSTEST registers to there original state as some OMAP generations do not
>    implement perform a soft-reset.
> 4. Clear the CON register after performing the bus clear, so when we call the
>    init function the controller is disabled and the init function will
>    re-enable later.
> 
> Original patch can be found here:
> http://git.omapzoom.org/?p=kernel/omap.git;a=commit;h=a2ab04192ba25e60f95ba1ff3af5601a2d7b5bd1
> 
> Signed-off-by: Vikram Pandita <vikram.pandita@ti.com>
> Signed-off-by: Jon Hunter <jon-hunter@ti.com>
> Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>

This has to wait a little bit until I can spend time on the recovery
framework (which is still in the queue, sadly :( ). There might be some
consolidation.

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120712/ce96a453/attachment-0001.sig>
