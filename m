From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 23 Jun 2017 14:28:58 +0200
Subject: [GIT PULL 2/2] SoCFPGA update for v4.13
In-Reply-To: <CAK8P3a1vZVQ5MZDU+qp62LCLnF8z-9LFH=c7XYj=ZnPUzVMjOA@mail.gmail.com>
References: <1498059352-9483-1-git-send-email-dinguyen@kernel.org>
 <1498059352-9483-2-git-send-email-dinguyen@kernel.org>
 <CAK8P3a1vZVQ5MZDU+qp62LCLnF8z-9LFH=c7XYj=ZnPUzVMjOA@mail.gmail.com>
Message-ID: <CACRpkdbCrKo7Uvhdyx+4_hMQrPCYaMMijHpYzEY+2MePjpr73g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 23, 2017 at 2:03 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Wed, Jun 21, 2017 at 5:35 PM, Dinh Nguyen <dinguyen@kernel.org> wrote:
>> Hi Arnd, Kevin, and Olof:
>>
>> Please pull in this SoCFPGA Kconfig update for v4.13.
>
> I'd like to defer this one until I hear back from the GPIO maintainers:
>
> With this patch, CONFIG_ARCH_NR_GPIO increases from 1024 to 2048
> in the ARM defconfig build. Is this ok in terms of runtime overhead?

There is no problem with runtime overhead, only with footprint.

The array of sizeof(gpio_desc) increases to double.

struct looks like so:

struct gpio_desc {
        struct gpio_device      *gdev;
        unsigned long           flags;
        const char              *label;
        const char              *name;
};

Looks like 4x32 bits in most cases, so this means a 4*4*1024 =
16 KiB footprint increase.

We have had to allocate this statically because so many playforms still
use the legacy GPIO API.

> If not, are there any alternatives?

Not really, if they have this many GPIOs.

Helping out ridding the kernel of users of the old GPIO global
numberspace ABI is appreciated though.

Yours,
Linus Walleij
