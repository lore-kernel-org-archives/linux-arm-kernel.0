From: Michael.McTernan.2001@cs.bris.ac.uk (Michael McTernan)
Date: Fri, 15 Jun 2012 09:36:14 +0100
Subject: ARM: iMX: lockup with irqs disabled in drivers/tty/imx.c
In-Reply-To: <CAOMZO5CDoJm8QgeA=r6k+hcZ-Z8sGZ19AgA1d8wWTGh3PaXmoQ@mail.gmail.com>
References: <4FB8CFBB.2020004@cs.bris.ac.uk>
 <CAOMZO5CDoJm8QgeA=r6k+hcZ-Z8sGZ19AgA1d8wWTGh3PaXmoQ@mail.gmail.com>
Message-ID: <4FDAF3FE.7000907@cs.bris.ac.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/12/2012 07:53 PM, Fabio Estevam wrote:
>> I can then trigger the lockup by simply booting the unit and issuing "echo>
>> /dev/ttymxc1".  The same can be done on the other ports too. Once locked,
>> magic sys-req appears not to work, pinging the target is dead etc...
>
> I did a 'echo "hello">  /dev/ttymxc1' and I am not able to see the
> lockup on a mx31pdk running 3.5-rc1.

Depending on the setup and board, you may find that the RTS pin is 
asserted so you don't hit the lockup, or more likely, that the Rx pin is 
being driven by a RS232 level shifter so you don't get the early break 
character which triggers the problem.

On my board the RTS will never be set and the Rx pin is pulled low so 
generates a break condition and lockup reliably (prior to patching).

I don't have a i.MX31 reference manual or PDK schematic, but you may be 
able to change the IO mux config to move the serial port Rx and RTS to 
free pins with pull downs in order to reproduce the bug.

This bug is very much a corner case, and arguably the hardware 
setup/board config isn't right, but for the sake of a few lines of code 
it would seem better to avoid such as nasty lockup which isn't 
straightforward to debug.

Regards,

Mike
