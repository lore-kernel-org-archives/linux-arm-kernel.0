From: dianders@chromium.org (Doug Anderson)
Date: Fri, 20 Feb 2015 11:03:56 -0800
Subject: [PATCH v4 0/3] about data busy
In-Reply-To: <1423894668-8886-1-git-send-email-addy.ke@rock-chips.com>
References: <1423828368-18456-1-git-send-email-addy.ke@rock-chips.com>
 <1423894668-8886-1-git-send-email-addy.ke@rock-chips.com>
Message-ID: <CAD=FV=U6T23wsJGCb2VoE7bQ=D2FdPgPGa+Fnp6aUBPXgiO5Zg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Feb 13, 2015 at 10:17 PM, Addy Ke <addy.ke@rock-chips.com> wrote:
> patch 1: This patch can fix bug that controller is still data busy after
>          reset all blocks. After this patch, I still get data busy in
>          set_ios().
>
> patch 2: This patch fix bug 'Timeout sending command'. After patch1 and
>          patch2, there is no mmc errors after:
>          cd /sys/bus/platform/drivers/dwmmc_rockchip
>          for i in $(seq 1 10000); do
>                 echo "========================" $i
>                 echo ff0c0000.dwmmc > unbind
>                 sleep .5
>                 echo ff0c0000.dwmmc > bind
>                 sleep 2
>         done
>
> patch3: This patch fix bug that there is data busy before sdio send CMD53.
>         But This patch is necessary for sd and mmc too.
>
> Addy Ke (3):
>   mmc: dw_mmc: update clock after host reach a stable voltage
>   mmc: dw_mmc: fix bug that cause 'Timeout sending command'
>   mmc: dw_mmc: Don't start command while data busy
>
>  drivers/mmc/host/dw_mmc.c | 41 ++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 40 insertions(+), 1 deletion(-)

A little hard to follow all the patches flying around (so I'll
probably reply a few different places with the same info), but I
believe that all of Addy's patches (with the exception of the one
intended to fix mmc_test which needs to be spun by him for a bugfix)
can be replaced with:

* mmc: dw_mmc: Don't start commands while busy
  https://patchwork.kernel.org/patch/5858221/

* mmc: dw_mmc: Make sure we only adjust the clock when power is on
  https://patchwork.kernel.org/patch/5858261/

* mmc: dw_mmc: Give a good reset after we give power
  https://patchwork.kernel.org/patch/5858281/


In order to avoid further spreading info out among several patches,
I'd request that you don't respond here but instead respond to my
posted patches.  Thanks!

-Doug
