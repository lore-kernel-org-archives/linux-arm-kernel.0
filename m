From: dianders@chromium.org (Doug Anderson)
Date: Wed, 25 Jun 2014 10:28:50 -0700
Subject: [PATCH 1/3] mmc: dw_mmc: use mmc_regulator_get_supply to handle
 regulators
In-Reply-To: <001201cf9067$3c5b2070$b5116150$%jun@samsung.com>
References: <1403520321-2431-1-git-send-email-yuvaraj.cd@samsung.com>
 <1403520321-2431-2-git-send-email-yuvaraj.cd@samsung.com>
 <CAD=FV=UGjm9y3XoBgWKjw9kp9W=ZrwB-S6Lh7T_LBUgCQZn1ag@mail.gmail.com>
 <53AA3F78.3080804@samsung.com>
 <001201cf9067$3c5b2070$b5116150$%jun@samsung.com>
Message-ID: <CAD=FV=UCinFuZQW+_GYFw=M046ziTLRNvvHUvsx_GQ0kjw5DfQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Seungwon,

On Wed, Jun 25, 2014 at 4:18 AM, Seungwon Jeon <tgih.jun@samsung.com> wrote:
>> >> +       case MMC_POWER_ON:
>> >> +               if (!IS_ERR(mmc->supply.vqmmc) &&
>> >> +                               !test_bit(DW_MMC_IO_POWERED, &slot->flags)) {
> You can use regulator_is_enabled() instead of flag bit, DW_MMC_IO_POWERED.

I'd be a little worried about regulator_is_enabled() since regulators
are reference counted.  What if someone else is sharing this
regulator?  The regulator might happen to be enabled when you check it
but unless you add your own dw_mmc reference count they might turn it
off.

> Important thing is that if powering vmmc failed at MMC_POWER_UP, vqmmc should not be powered.

Good point.
