From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 1 May 2012 15:37:13 +0100
Subject: [PATCH 2/2] I2C: Implement DMA support into mxs-i2c
In-Reply-To: <20120501135800.GL2194@S2101-09.ap.freescale.net>
References: <1335738969-27445-1-git-send-email-marex@denx.de>
 <201204302207.39112.marex@denx.de> <20120430203016.GD28226@pengutronix.de>
 <201204302245.57958.marex@denx.de> <20120430210108.GE28226@pengutronix.de>
 <20120501135800.GL2194@S2101-09.ap.freescale.net>
Message-ID: <20120501143712.GB3548@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 01, 2012 at 09:58:03PM +0800, Shawn Guo wrote:
> On Mon, Apr 30, 2012 at 11:01:08PM +0200, Wolfram Sang wrote:
> > 
> > > > > It complains that data might be undefined, do you want it in a separate
> > > > > patch then ?
> > > > 
> > > > Yes, but only if you can prove that the compiler is right.
> > > 
> > > It's not right, because that variable is always initialized, but this at least 
> > > squashes the compile warning.
> > 
> > The compiler needs to be fixed, not the kernel.
> > 
> Heh, this is coming up again.  I'm not convincing you to take the
> change, but just curious what if this is not a compile warning but
> an error for the same cause that compiler is not right.

It's a compiler warning.

Please look at the wording of the warning.  The compiler uses "may" not
"is".  That means it can't come to a conclusion about it.

But we, as humans with our biological inference engines, can see that
the code is correct, and we _can_ choose to ignore the warning -
just like I do with:

drivers/video/omap2/displays/panel-taal.c: In function 'taal_num_errors_show':
drivers/video/omap2/displays/panel-taal.c:605: warning: 'errors' may be used uninitialized in this function

static int taal_dcs_read_1(struct taal_data *td, u8 dcs_cmd, u8 *data)
{
        int r;
        u8 buf[1];
        r = dsi_vc_dcs_read(td->dssdev, td->channel, dcs_cmd, buf, 1);
        if (r < 0)
                return r;
        *data = buf[0];  
        return 0;
}

        u8 errors;

        mutex_lock(&td->lock);
        if (td->enabled) {
                dsi_bus_lock(dssdev);
                r = taal_wake_up(dssdev);
                if (!r) 
                        r = taal_dcs_read_1(td, DCS_READ_NUM_ERRORS, &errors);
                dsi_bus_unlock(dssdev);
        } else {
                r = -ENODEV;
        }
        mutex_unlock(&td->lock);

        if (r)
                return r;

        return snprintf(buf, PAGE_SIZE, "%d\n", errors);

See?  We can infer from the above that that 'errors' will always be set
if r is zero - but the compiler is saying it's not clever enough to do
that automatically.

This doesn't mean the code _has_ to be changed - we can see that the
above warning is false.  Though, if there is a way to rewrite it to make
it easier for us humans to read and that makes the warning go away, it
_might_ be a good idea to make the change - but only for a maintainability
reason.

The reverse is also true - if trying to fix a warning like this makes
the code more difficult to understand, then the warning _should_ stay.

That's actually the point of programming languages - the ability to
express our instructions to a computer in a way that both we and the
compiler can readily understand.  The most important part of that is
that _we_ understand what's been written.
