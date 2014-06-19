From: bjorn@kryo.se (Bjorn Andersson)
Date: Thu, 19 Jun 2014 11:22:41 -0700
Subject: [PATCH v3 0/3] Qualcomm Resource Power Manager driver
In-Reply-To: <CAJe_ZhfmsgvnVu-VgN63LaZ-522HuAY_EVfB6ujQjdzBE+u=zA@mail.gmail.com>
References: <1402944372-31901-1-git-send-email-bjorn.andersson@sonymobile.com>
 <7hvbrzbh1u.fsf@paris.lan>
 <CAJAp7OhHr4Cgcp9pvQ3=MAie_zSnFJxG28Vf37qJ98BK7P1jaQ@mail.gmail.com>
 <7hzjha8b97.fsf@paris.lan>
 <842A7147-A2CC-42BD-9947-CBADF738DC92@codeaurora.org>
 <7hegym6uca.fsf@paris.lan>
 <CAJe_ZhfmsgvnVu-VgN63LaZ-522HuAY_EVfB6ujQjdzBE+u=zA@mail.gmail.com>
Message-ID: <CAJAp7OgfsVs9C0RNrDnQ5g7heba7JjaYFrj7wVUqT_m+wu-A3A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 18, 2014 at 8:55 PM, Jassi Brar <jaswinder.singh@linaro.org> wrote:
> On 18 June 2014 22:14, Kevin Hilman <khilman@linaro.org> wrote:
[...]
>> Thinking more about what this RPM driver actually does, and since you
>> mentioned patterns across SoCs, it seems to me the RPM driver bascially
>> just doing the IPC.
>>
>> So, rather than MFD or drivers/soc, it seems to me that it should be
>> implmented as a controller in the new common mailbox framwork[1] being
>> worked on by Jassi Brar (added to Cc.)
>>
>> IIUC, RPM is actually only doing one-way IPC (it only exposes a write()
>> interface to clients) so it seems like a rather simple implementation of
>> a mailbox controller.
>>
> Yup, qcom_rpm.c is exactly what drivers/mailbox/ is meant for.
>

The RPM provides a register file with 80ish registers of variable size, to
program the hardware you write to these registers. Then you write to a register
selector register and then signal an outgoing interrupt.

That is, the interface exposed to the kernel by the SoC is not an mailbox like
interface.

So I do not share your view that this is "exactly what mailbox is meant for",
because if so then you're just re-inventing regmap - with variable size regs.


The reason why I'm not using a regmap as my abstraction between the rpm and the
clients (e.g. regulator driver) is because it only supports fixed size
registers.


To me the mailbox api is supposed to abstract communication hardware, not to
abstract communication between software components.

Regards,
Bjorn
