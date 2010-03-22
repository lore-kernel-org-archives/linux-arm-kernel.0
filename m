From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Sun, 21 Mar 2010 20:58:28 -0400
Subject: Using of cached values
In-Reply-To: <2703439e1003200222y16147d81x27b0a8bcc804c338@mail.gmail.com>
References: <2703439e1003200222y16147d81x27b0a8bcc804c338@mail.gmail.com>
Message-ID: <771cded01003211758l1e6627berc57f718f017683ed@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 20, 2010 at 5:22 AM, Mogambo Park <mogambo.kztrj@gmail.com> wrote:
> good morning
>
> ?I wants to know - How safe to read register values one time in a structure
> and use value from there, assume no write is performed on the
> register? I see many
> files in sound/soc/codec/ do that.
Of course, it's safe. Since registers (CONTROL registers) are only
updated by processor, all writing operations are managed by codec
driver.

>
> is it becos sometime the register may return not accurate value on
> busy bus by h/w mistake?
> OR I should always read from register even if his value is not
> expected to change?
>

Using cached registers is based on suche reasons in below.

1. Some chip can only support write. Reading register isn't supported
by hardware, like WM8753 (codec with I2C interface), MAX8660(PMIC). So
we have to use cache registers.
2. We use cache registers because of performance and power benefit. In
platform, codec or PMIC is always connected to bus. Accessing these
chips cost time and power. All CONTROL (not STATUS) registers should
only be updated by processor. Processor should be the only one owner
of these chips. So we could use cache registers for CONTROL registers.

Thanks
Haojian
