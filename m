From: moinejf@free.fr (Jean-Francois Moine)
Date: Fri, 17 May 2013 08:37:43 +0200
Subject: [PATCH 1/9] I2C: mv64xxx: work around signals causing I2C
 transactions to be aborted
In-Reply-To: <E1Ud4pH-0004JQ-Jq@rmk-PC.arm.linux.org.uk>
References: <20130516202921.GW18614@n2100.arm.linux.org.uk>
 <E1Ud4pH-0004JQ-Jq@rmk-PC.arm.linux.org.uk>
Message-ID: <20130517083743.31af4eb0@armhf>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 16 May 2013 21:30:59 +0100
Russell King <rmk+kernel@arm.linux.org.uk> wrote:

> Do not use interruptible waits in an I2C driver; if a process uses
> signals (eg, Xorg uses SIGALRM and SIGPIPE) then these signals can
> cause the I2C driver to abort a transaction in progress by another
> driver, which can cause that driver to fail.  I2C drivers are not
> expected to abort transactions on signals.

Hi Russell,

I had the same problem with my dove drm driver, but I don't fully agree
with your solution.

Using wait_event_timeout() stops the system, and reading the EDID from
an external screen may take some time.

Instead, as the problem occurs with the X server on HDMI exchanges,
I acted on the tda998x driver, simply masking the SIGALRM and SIGPIPE
signals on each drm driver request.

This mechanism works fine for me. Patch follows.

-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
