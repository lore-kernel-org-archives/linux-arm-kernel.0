From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 10 Oct 2013 16:22:38 +0200
Subject: [PATCH 3/6] ARM: integrator: delete non-devicetree boot path
In-Reply-To: <20131008095148.GD28972@e106331-lin.cambridge.arm.com>
References: <1380816202-3128-1-git-send-email-linus.walleij@linaro.org>
 <20131008095148.GD28972@e106331-lin.cambridge.arm.com>
Message-ID: <CACRpkdZvV9Ck-wG9w+=wh1DvvyddYj0k7WUB9aQMT9V4yH+Ykw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 8, 2013 at 11:51 AM, Mark Rutland <mark.rutland@arm.com> wrote:

>> +       /* Remap the Integrator system controller */
>> +       ap_syscon_base = ioremap(INTEGRATOR_SC_BASE, 0x100);
>
> It seems a shame that this didn't get described in the DT. This hasn't
> been fully moved over...

No. There is still stuff to move over, and not only the system controller,
also the EBI (external bus interface) on the AP.

But we can still work from this point, or do you mean that we cannot
proceed to delete the ATAG boot path before we fix this?

My idea is that deleting this makes the code easier to handle after
the shrink.

>> +       if (!ap_syscon_base) {
>> +               dev_err(&pdev->dev, "unable to remap the AP syscon for PCIv3\n");
>> +               return -ENODEV;
>> +       }
>> +
>> +       /* Device tree probe path */
>> +       if (!np) {
>> +               dev_err(&pdev->dev, "no device tree node for PCIv3\n");
>> +               return -ENODEV;
>> +       }
>
> We didn't unmap the syscon registers, yet we mapped them here. Either
> we've got a useless mapping, or we're mapping it from the wrong block of
> code...

Sorry I'm not following this. The only thing the patch does is remove the
ATAG boot path, moving the relevant part of the DT boot path over
to the DT probe function and renaming it pci_v3_probe() in the process
which might make the patch messy but that is all it does.

If you mean that we should unmap the syscon base you're right
but that would be a separate patch, right?

I'll write a separate patch for that instead using devm_* so we
don't have to unmap it by calling any special function.

Yours,
Linus Walleij
