From: jean-nicolas.graux@stericsson.com (Jean-Nicolas GRAUX)
Date: Tue, 12 Feb 2013 17:26:06 +0100
Subject: Getting your opinion about the best place to put one specific
 device driver...
In-Reply-To: <201302121454.10231.arnd@arndb.de>
References: <511A0F11.1050608@stericsson.com>
 <201302121454.10231.arnd@arndb.de>
Message-ID: <511A6D1E.50705@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, here are my answers below.

Le 02/12/2013 03:54 PM, Arnd Bergmann a ?crit :
> On Tuesday 12 February 2013, Jean-Nicolas GRAUX wrote:
>> ello, Arnd, Olof. First, let me introduce myself quickly.
>> I am working in Stericsson and i am a colleague of Linus Walleij.
>> We are currently doing some cleaning in our mach-ux500 ARM machine.
>>
>> Among other things, the U8500 SoC and its derivatives embed one small IP
>> called the "hardware observer".
>> This is used for hardware debug purpose and it provides the ability to
>> output some
>> modem, power, clocking, ..., hardware signals on 18 external wires.
>>
>> We did one small platform device driver to handle this piece of hardware.
>> In the patch attached to this file, we kept the code in the mach-ux500
>> machine folder.
>> But we are wondering where is the best place to put that stuff.
>> So, the question is: where should we put this code in the kernel tree ?
>   
> Hi Jean-Nicolas,
>
> I think I need some more information to understand what that interface
> you are driving is actually about, since that is not clear from your
> description or from reading the source code.
>
> Why are there exactly 18 wires?
As you can imagine, this module is very specific to the ux500 digital 
baseband family.
So, ux500 SoCs simply provide 18 external IOs that may be used to 
observe some critical hardware signals.
Depending on what has been configured in the hwobs control registers, we 
are able to observe
signals from the modem, the ddr controllers, the prcmu, the gfx ip, the 
clock tree, ...
>
> What is the protocol that is used on these wires (i2c, spi, rs232, ...)
There is no specific devices connected behind those wires. So, no 
protocol used.
Usually, once the required configuration has been set thanks to the 
debugfs interface,
we directly monitor the signals by connecting the wires to a 
oscilloscope or a digital analyser...
>
> Why do you actually need run-time configuration in the kernel?
Main aim of this driver is just to provide a user interface to 
configure/enable the hardware observer
so that we may easily select the required signals to observe. Having 
that at run time is mandatory for us.
This is mainly used by software/hardware teams to debug and verify 
modem/ape power states.
>
> It does look however like this code is related to the PRCMU, so maybe
> it should be part of the prcmu driver rather than a separate device?
It is true that the hardware observer registers are located in the 
"PRCM" unit.
But to my mind, it has no real link with the dbx500-prcmu driver itself yet.
(dbx500-prcmu driver is dedicated to the handling of the communication
between the kernel and the firmware that run inside PRCMU xp70 controller.)
Moreover, I think we should keep a separate device for the harware observer
since it need to acquire its own pinctrl state.
That said, we might consider moving it to the mfd folder ?

To be honest, in my initial patch, i was aiming to put the ux500_hwobs.* 
files in the "misc" folder.
But Linus told me that this was probably not the good place ;)
Regards.
>
> 	Arnd
