From: peter.griffin@linaro.org (Peter Griffin)
Date: Tue, 23 Sep 2014 19:02:55 +0100
Subject: [STLinux Kernel] [PATCH 1/3] media: st-rc: move to using
 reset_control_get_optional
In-Reply-To: <1411424546-12718-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1411424501-12673-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1411424546-12718-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <20140923180255.GA3430@griffinp-ThinkPad-X1-Carbon-2nd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Srini,

On Mon, 22 Sep 2014, Srinivas Kandagatla wrote:

> This patch fixes a compilation error while building with the
> random kernel configuration.
> 
> drivers/media/rc/st_rc.c: In function 'st_rc_probe':
> drivers/media/rc/st_rc.c:281:2: error: implicit declaration of
> function 'reset_control_get' [-Werror=implicit-function-declaration]
>   rc_dev->rstc = reset_control_get(dev, NULL);
> 
> drivers/media/rc/st_rc.c:281:15: warning: assignment makes pointer
> from integer without a cast [enabled by default]
>   rc_dev->rstc = reset_control_get(dev, NULL);

Is managing the reset line actually optional though? I can't test atm as I don't have
access to my board, but quite often if the IP's aren't taken out of reset reads / writes
to the perhpiheral will hang the SoC.

If managing the reset line isn't optional then I think the correct fix is to add
depends on RESET_CONTROLLER in the kconfig.

This will then do the right thing for randconfig builds as well.

regards,

Peter.
