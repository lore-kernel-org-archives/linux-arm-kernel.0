From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 21 Aug 2014 11:04:07 +0200
Subject: [PATCH v4 00/11] drm: add support for Atmel HLCDC Display
 Controller
In-Reply-To: <20140821103706.2349915d@bbrezillon>
References: <1406034695-15534-1-git-send-email-boris.brezillon@free-electrons.com>
 <20140821081619.GZ2452@ldesroches-Latitude-E6320>
 <20140821103706.2349915d@bbrezillon>
Message-ID: <20140821090406.GA13733@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 21, 2014 at 10:37:06AM +0200, Boris BREZILLON wrote:
> Hi Ludovic,
> 
> On Thu, 21 Aug 2014 10:16:19 +0200
> Ludovic Desroches <ludovic.desroches@atmel.com> wrote:
> 
> > Hi Boris,
> > 
> > You can add
> > 
> > Tested-by: Ludovic Desroches <ludovic.desroches@atmel.com>
> 
> Thanks for testing this driver.
> 
> > 
> > Only one issue but not related to your patches, you can't display
> > quickly the bootup logo since the panel detection takes too much
> > time.
> 
> Yes, actually this is related to the device probe order: the
> hlcdc-display-controller device is probed before the simple-panel, thus
> nothing is detected on the RGB connector (I use of_drm_find_panel to
> check for panel availability) when the display controller is
> instantiated. I rely on the default polling infrastructure provided by
> the DRM/KMS framework which polls for a new connector every 10s, and
> this is far more than you kernel boot time.
> 
> Do anyone see a solution to reduce this delay (without changing the
> polling interval). I thought we could add a notifier infrastructure to
> the DRM panel framework, but I'm not sure this is how you want things
> done...

Other drivers return -EPROBE_DEFER when a panel hasn't been registered
yet. This will automatically take care of ordering things in a way that
DRM/KMS will only be initialized after the panel has been probed. That
will still cause some delay before everything gets set up, but hopefully
less than what you're seeing now. There's also another thread where this
is being discussed because deferred probing is causing "unacceptable"
delays as well.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140821/5a32aeba/attachment.sig>
