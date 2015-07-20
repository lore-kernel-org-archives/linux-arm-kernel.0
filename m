From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 20 Jul 2015 09:43:41 +0200
Subject: [RFC PATCH 00/15] pwm: add support for atomic update
In-Reply-To: <1435738921-25027-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1435738921-25027-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <20150720074339.GA29614@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 01, 2015 at 10:21:46AM +0200, Boris Brezillon wrote:
> Hello Thierry,
> 
> This series adds support for atomic PWM update, or ITO, the capability
> to update all the parameters of a PWM device (enabled/disabled, period,
> duty and polarity) in one go.
> 
> This implementation is still experimental, and I may have missed some key
> aspect, so any feedback are welcome.
> 
> Also note that I haven't protected the state update with any locking.
> That's because the existing config does not protect against concurrent
> access to a requested PWM device (see the pwm_config implementation).
> I guess the PWM framework assume the user will implement the proper locking
> scheme if it has to concurrently access the device.

Actually the reason why no protection is needed is because there can
ever only be a single user of a PWM channel. pwm_request() will only
hand out a handle to the PWM channel if it hasn't been requested
before.

And in the unlikely case where a single user wants to use the same PWM
channel from different threads, then it will have to use locking for
other reasons already, so accesses to the PWM can be serialized using
the same mechanism.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150720/5ba28c7a/attachment.sig>
