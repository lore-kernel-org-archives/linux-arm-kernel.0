From: andrew.smirnov@gmail.com (Andrey Smirnov)
Date: Sun, 7 Jan 2018 22:24:40 -0800
Subject: soc: imx: gpcv2: removing and probing fails
In-Reply-To: <CAHQ1cqHvkk01NDTB14PpG4tgpsbPg=75K9wqHUCBjWkyNuFy=A@mail.gmail.com>
References: <3f836677c6e98aaf01bc1ac8c3410083@agner.ch>
 <CAHQ1cqHvkk01NDTB14PpG4tgpsbPg=75K9wqHUCBjWkyNuFy=A@mail.gmail.com>
Message-ID: <CAHQ1cqEutLV7wRWq3FdU1CyercLiiDgNL0trSuV5p-x7eGYFVg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 7, 2018 at 4:22 PM, Andrey Smirnov <andrew.smirnov@gmail.com> wrote:
> On Sun, Jan 7, 2018 at 2:48 AM, Stefan Agner <stefan@agner.ch> wrote:
>> Hi Andrew,
>>
>> I noticed that the driver fails when removing and probing again. As far
>> as I can see due to duplicate add of the platform devices.
>>
>> As far as I can tell the driver should register the remove callback and
>> do a platform_device_unregister on the newly created platform devices.
>> However, as far as I can tell we don't hold on to a reference to them...
>> I guess we could keep references in imx_gpcv2_probe, but maybe there is
>> an easier way?
>
> Stefan:
>
> Good catch and sorry for the inconvenience. I just spent a little bit
> of time repro-ing this and it looks like there are two separate bugs,
> actually. First one, as you correctly pointed out, is due to
> re-registration of pm-domain platform drivers. That, however, should
> only result in a WARNING and a failed driver probing, not in a killed
> init due to BUG. So the second one, that BUG message in the stack
> trace, is due to the fact that I incorrectly provide statically
> allocated data via dev.platform_data and it ends up being kfree'd in
> platform_device_release().
>
> IMHO, this driver isn't really meant to be removed, so the simplest
> solution to the first problem would be to specify
> "imx_gpc_driver.driver.suppress_bind_attrs = true" and remove any
> option to remove the driver, but I don't know if that's acceptable or
> not.
>
> Shawn, would the above be acceptable upstream?
>
> Solution for bug #2 is trivial and I'll send patches for both once we
> agree how to fix #1.
>
> Thanks,
> Andrey Smirnov
>
> P.S: Also, since I based my code on gpc.c, I suspect that driver will
> have exactly the same problem (I'll do some experiments to confirm)

Done with experiments. Same problem happens with gpc.c as well.

Andrey Smirnov
