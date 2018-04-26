From: michal.simek@xilinx.com (Michal Simek)
Date: Thu, 26 Apr 2018 15:35:26 +0200
Subject: [PATCH] gpio: zynq: Setup chip->base based on alias ID
In-Reply-To: <CACRpkdbOa+AvhQT1RCWA_zQuTpp4qfNjZBFDOKLdaFqMGAe+cw@mail.gmail.com>
References: <6ee982f8eb6e07f9ecbb0cc5093152f4a16b9c31.1523454899.git.michal.simek@xilinx.com>
 <CACRpkdbOa+AvhQT1RCWA_zQuTpp4qfNjZBFDOKLdaFqMGAe+cw@mail.gmail.com>
Message-ID: <f9dd4f64-4026-f495-5810-32affb5b0944@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

On 26.4.2018 15:08, Linus Walleij wrote:
> On Wed, Apr 11, 2018 at 3:55 PM, Michal Simek <michal.simek@xilinx.com> wrote:
> 
> Thanks for your patch!
> 
>> In past Xilinx gpio-zynq driver was setting up gpio chip->base as 0
>> which was chagned to autodetection when driver was upstreamed. Older
>> systems, which were using this old version, setup SW stack which expects
>> zynq gpio base as 0 and right now there is no way how to set this up.
>>
>> The patch is adding an option to setup chip->base based on aliases which
>> is something what some other drivers are doing too.
>> It means when gpio0 alias is setup then chip->base is 0. When gpio alias
>> is not setup gpiochip_find_base() set it up properly which is current
>> behavior.
>>
>> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> 
> In general, we stopped any controlling of the GPIO base.

I know.

> 
> Also this use would have to be OK with the DT maintainers
> as I never saw this use of alias before.

If you grep gpio drivers you will see that these gpio-zx, gpio-mvebu,
gpio-mxc, gpio-mxs, gpio-vf610 are using that.

> 
> Please describe the use case for this.
> 
> The only use case which I can think about is userspace sysfs
> and then I would really like to know why these userspace
> users cannot use the character device that is nowadays
> supported by libgpiod and there is even patches for some
> IoT libraries to use it. The character device makes the
> GPIO Linux "base" irrelevant for userspace.
> 
> GPIO sysfs is deprecated and moved to the obsolete ABI.
> 
> If there are legacy applications that use this I would have
> to consider it, but since this has been -1 since the driver
> was merged I find that unlikely.

Yes, it is about legacy application which I have seen recently and there
is no source code for application calls it because board vendor doesn't
provide it.

You are right that -1 was used from the beginning in mainline but
unfortunately this driver was in vendor tree for a while and it uses 0
there.

In upstreaming this was changed to -1 but customers have a lot of code
which developed against vendor tree and they want to use
latest&greatest. And without this they are not able to run that
applications.

I found that this logic is already in 5 drivers in mainline that's why I
send this patch to be +1.

Thanks,
Michal
