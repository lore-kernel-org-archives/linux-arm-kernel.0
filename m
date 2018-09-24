From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 24 Sep 2018 13:53:01 +0200
Subject: [RESEND PATCH] Revert "pwm: Set class for exported channels in
 sysfs"
In-Reply-To: <1537538567-5377-1-git-send-email-fabrice.gasnier@st.com>
References: <1537538567-5377-1-git-send-email-fabrice.gasnier@st.com>
Message-ID: <20180924115301.GV21032@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 21, 2018 at 04:02:47PM +0200, Fabrice Gasnier wrote:
> This reverts commit 7e5d1fd75c3dde9fc10c4472b9368089d1b81d00 as it causes
> regression with multiple pwm chip. It creates a new entry in
> '/sys/class/pwm' every time a 'pwmX' is exported with 'echo X > export':
> - 1st time export will create an entry in /sys/class/pwm/pwmX
> - when another export happens on another pwmchip, it can't be created
> (e.g. -EEXIST)
> 
> This also changes existing ABI (Documentation/ABI/testing/sysfs-class-pwm):
> - pmwX should be there: /sys/class/pwm/pwmchipN/pwmX
> 
> Example on stm32 (stm32429i-eval) platform:
> $ ls /sys/class/pwm
> pwmchip0 pwmchip4
> 
> $ cd /sys/class/pwm/pwmchip0/
> $ echo 0 > export
> $ ls /sys/class/pwm
> pwm0 pwmchip0 pwmchip4
> 
> $ cd /sys/class/pwm/pwmchip4/
> $ echo 0 > export
> sysfs: cannot create duplicate filename '/class/pwm/pwm0'
> ...Exception stack follows...
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> ---
>  drivers/pwm/sysfs.c | 1 -
>  1 file changed, 1 deletion(-)

Can we come up with an alternative that allows us to have both? We want
uevent and proper sysfs creation, or is that not possible?

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180924/fadb97fa/attachment.sig>
