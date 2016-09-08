From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 8 Sep 2016 11:23:54 +0200
Subject: [PATCH] pwm: meson: handle unknown ID values
In-Reply-To: <20160906125106.1511562-1-arnd@arndb.de>
References: <20160906125106.1511562-1-arnd@arndb.de>
Message-ID: <20160908092354.GB24112@ulmo.ba.sec>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 06, 2016 at 02:50:47PM +0200, Arnd Bergmann wrote:
> When building with -Wmaybe-uninitialized, we get a couple of harmless
> warnings about three functions in this new driver that don't look
> safe to the compiler:
> 
> drivers/pwm/pwm-meson.c: In function 'meson_pwm_get_state':
> drivers/pwm/pwm-meson.c:355:26: error: 'mask' may be used uninitialized in this function [-Werror=maybe-uninitialized]
> drivers/pwm/pwm-meson.c: In function 'meson_pwm_disable':
> drivers/pwm/pwm-meson.c:263:13: error: 'enable' may be used uninitialized in this function [-Werror=maybe-uninitialized]
> drivers/pwm/pwm-meson.c: In function 'meson_pwm_apply':
> drivers/pwm/pwm-meson.c:231:13: error: 'clk_shift' may be used uninitialized in this function [-Werror=maybe-uninitialized]
> drivers/pwm/pwm-meson.c:231:36: error: 'enable' may be used uninitialized in this function [-Werror=maybe-uninitialized]
> drivers/pwm/pwm-meson.c:231:24: error: 'clk_enable' may be used uninitialized in this function [-Werror=maybe-uninitialized]
> 
> Specifically, if we have a device with an id other than 0 or 1,
> this would result in undefined behavior. This is currently not
> possible, but the compiler cannot be expected to know this.
> 
> This patch adds a 'default' clause to let the compiler know
> what to do instead, which shuts up the warning and makes the
> code slightly more resiliant in case it gets extended to other
> identifiers.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/pwm/pwm-meson.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)

Applied, though I left out the dummy assignment of state->enabled = 0
because that's dead code anyway.

Thanks,
Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160908/2815d65e/attachment-0001.sig>
