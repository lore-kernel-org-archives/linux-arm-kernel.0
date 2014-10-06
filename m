From: ssreedharan@mvista.com (Sudhir Sreedharan)
Date: Mon, 6 Oct 2014 15:18:15 +0530
Subject: [PATCH] serial/core: Initialize the console pm state
In-Reply-To: <CAMuHMdWwEoK__-qTdUmzx6vJJSQ1+XdvL3nZukUX_RjM1tDVGA@mail.gmail.com>
References: <1411367422-2095-1-git-send-email-ssreedharan@mvista.com>
 <CAMAWPa9R5HtGKkV=Ya-ekynY5maespZ0Q6BjwJcX3LN3857ZjQ@mail.gmail.com>
 <CAMuHMdWwEoK__-qTdUmzx6vJJSQ1+XdvL3nZukUX_RjM1tDVGA@mail.gmail.com>
Message-ID: <CAJJ77Wsec5TbeQrKsa2qU9c=SsQdFoSZC5RpXadwdNKYAjDPdw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Geert,

On Fri, Oct 3, 2014 at 5:52 PM, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Wed, Oct 1, 2014 at 7:27 PM, Kevin Hilman <khilman@kernel.org> wrote:
>> On Sun, Sep 21, 2014 at 11:30 PM, Sudhir Sreedharan
>> <ssreedharan@mvista.com> wrote:
>>> For console devices having UART_CAP_SLEEP capability, the uart_pm_state has
>>> to be initialized to UART_PM_STATE_ON. Otherwise the LCR regiser values
>>> are reinitialized when uart_change_pm is called from uart_configure_port.
>>>
>>> Signed-off-by: Sudhir Sreedharan <ssreedharan@mvista.com>
>>
>> Multiple boot failures on ARM[1] were bisected down to this patch.
>>
>> How was this patch tested, and on which platforms?
>>
>> Also, the changelog states that this should be done only for
>> UART_CAP_SLEEP, but the patch does it for every UART.
>>
>> Greg, I suggest this patch be dropped from tty-next until it has been
>> better described and tested.
>>
>> Kevin
>>
>> [1] http://lists.linaro.org/pipermail/kernel-build-reports/2014-October/005550.html
>
> Perhaps it should call "uart_change_pm(state, UART_PM_STATE_ON)"
> instead, so the driver's .pm() method is called?
>

If  "uart_change_pm(state, UART_PM_STATE_ON);" is called, it will
reinitialize the LCR register, thus changing the configuration of
console port. This will throw garbage characters from the point where
the serial driver initializes till startup is called from userland.

Thanks,
Sudhir
