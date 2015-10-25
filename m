From: wsa@the-dreams.de (Wolfram Sang)
Date: Sun, 25 Oct 2015 09:37:48 +0100
Subject: [PATCH-v5 RESEND 4/5] Documentation: binding: add sclk
 adjustment properties to i2c-pxa
In-Reply-To: <1440395978-9065-5-git-send-email-vaibhav.hiremath@linaro.org>
References: <1440395978-9065-1-git-send-email-vaibhav.hiremath@linaro.org>
 <1440395978-9065-5-git-send-email-vaibhav.hiremath@linaro.org>
Message-ID: <20151025083748.GC2159@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 24, 2015 at 11:29:37AM +0530, Vaibhav Hiremath wrote:
> With addition of PXA910 family of devices, the TWSI module supports
> new feature which allows us to adjust SCLK. i2c-pxa driver takes input
> configuration in nsec and converts it to respective bit-fields,
> 
>  - i2c-sclk-low-time-ns : SCLK low time (tlow)
>    This property is used along with mode selection.
>  - i2c-sclk-high-time-ns : SCLK high time (thigh)
>  - i2c-start-hold-time-ns : Used in case of high speed mode for start bit
>    hold/setup wait counter.
>  - i2c-stop-hold-time-ns : Used in case of high speed mode for stop bit
>    hold/setup wait counter.
>  - i2c-sda-hold-time-ns : Used to calculate hold/setup wait counter for
>    standard and fast mode.
> 
> Signed-off-by: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>

Ooookay, after checking some datasheets, I finally stumbled over the
fact that this driver is not using "clock-frequency" to determine the
bus speed. However, this is the standard way of defining that in DT, so
this driver should adhere to that, too, and not invent something new.
Previously, I was under the impression that the above parameters were
needed for fine-tuning and couldn't fully grasp why. But this is for
defining the bus speed which is a no-go.

It looks to me that older PXA only have a bit to select between 100 and
400kHz while this newer one can have arbitrary frequencies. Correct?

So, what the driver should do:

- Keep support for the old "mrvl,i2c-fast-mode" binding which should be
  marked as deprecated

- get the value of the standard property "clock-frequency"

- for old PXAs, complain if not 100 or 400kHz, otherwise set the bit
  accordingly

- for new PXAs, calculate the ilcr and iwcr values from
  "clock-frequency"

Makes sense?

Regards,

   Wolfram

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151025/634e4f47/attachment.sig>
