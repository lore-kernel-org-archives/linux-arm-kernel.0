From: ludovic.desroches@atmel.com (Ludovic Desroches)
Date: Wed, 17 Jun 2015 14:38:16 +0200
Subject: [RESEND PATCH 1/2] pinctrl: change function behavior for per pin
 muxing controllers
In-Reply-To: <557EF60D.8020007@wwwdotorg.org>
References: <1433948699-19800-1-git-send-email-ludovic.desroches@atmel.com>
 <1433948699-19800-2-git-send-email-ludovic.desroches@atmel.com>
 <557EF60D.8020007@wwwdotorg.org>
Message-ID: <20150617123816.GB12295@odux.rfo.atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,

On Mon, Jun 15, 2015 at 09:58:05AM -0600, Stephen Warren wrote:
> On 06/10/2015 09:04 AM, Ludovic Desroches wrote:
> >When having a controller which allows per pin muxing, declaring with
> >which groups a function can be used is a useless constraint since groups
> >are something virtual.
> 
> This isn't true.
> 
> Irrespective of whether a particular piece of pinmux HW can control the mux
> function for each pin individually, or only in groups, it's quite likely
> that each function can only be selected onto a subset of those pins or
> groups. Requiring the pinctrl driver to inform the core which set of
> pins/groups particular functions can be selected onto seems quite
> reasonable.
> 
> In my opinion at least, for HW that can select the mux function at the
> per-pin level, the only sensible set of groups is one group per pin with
> each group containing a single pin. Any other use of groups is a
> SW/user-level construct, and is something unrelated to why the pinctrl
> subsystem supports groups. If we want to represent those groups in pinctrl,
> there should be two separate sets of groups; one to represent the actual HW
> capabilities, and one to represent the SW/user-level convenience
> abstractions.

Groups that I would like to use are not something related to the user or
software. It's an hardware reality but they would be more flexibles.

Usually the muxing is done by selecting a function (which seems to be
device related: usart, spi, etc.), then you select on which pins you
want this function.

In my case, I can't select a function only by choosing a mux. It is a
combination of the mux and the pin on which it is applied. So my
functions will be GPIO, A, B, C, etc. If I use function A on pin 12, I
will have my i2c clock signal but I can have this signal on pin 58 if I
use function C. Do you understand what I mean? It's not very easy to
explain... So here is a real example:

 -------------------------------------------------- 
|              | pio peripheral                    |
 -------------------------------------------------- 
| signal | dir | func | signal       | dir | ioset |
 -------------------------------------------------- 
| PA8    | I/O | A    | SDMMC0_DAT6  | I/O | 1     |
|        |     | B    | QSPI1_IO1    | I/O | 1     |
|        |     | D    | TCLK5        | I   | 1     |
|        |     | E    | FLEXCOM2_IO2 | I/O | 1     |
|        |     | F    | NWE/NANDWE   | O   | 2     |
 -------------------------------------------------- 
| PD28   | I/O | A    | SPI1_NPCS0   | I/O | 3     |
|        |     | B    | TDI          | I/O | 3     |
|        |     | C    | FLEXCOM2_IO2 | I   | 2     |
 -------------------------------------------------- 


You are right that having a group per pin is a solution.

If I follow your proposal (tell me if I'm wrong):
- I will have 128 groups since I have 128 pins.
- I will have functions GPIO, A, B, C, D, E, F.
- I have to give the groups which can achieve a function so I will have
128 groups for each function. It means 128 x 7 = 896 groups.

Does it seems to be something reasonable and intelligible? From my point
of view no. And what about the sysfs readability?

With my current implementation, I have something quite understandable
for the user if he needs to check the pinmuxing:

  # cat /sys/kernel/debug/pinctrl/ahb\:apb\:pinctrl at fc038000/pinmux-pins
  pin 17 (PA17): (MUX UNCLAIMED) (GPIO UNCLAIMED)
  pin 18 (PA18): b0000000.sdio-host (GPIO UNCLAIMED) function E group sdmmc1_0
  pin 19 (PA19): b0000000.sdio-host (GPIO UNCLAIMED) function E group sdmmc1_0  
                                                                                
  # cat /sys/kernel/debug/pinctrl/pinctrl-maps                                  
  Pinctrl maps:                                                                 
                                                                                
  device b0000000.sdio-host                                                     
  state default                                                                 
  type MUX_GROUP (2)                                                            
  controlling device ahb:apb:pinctrl at fc038000                                   
  group sdmmc1_0                                                                
  function E                                                                    
                                                                                
  device b0000000.sdio-host                                                     
  state default                                                                 
  type CONFIGS_PIN (3)                                                          
  controlling device ahb:apb:pinctrl at fc038000                                   
  pin PA28                                                                      
  config 00010003                                                               
                                                                                
  device b0000000.sdio-host                                                     
  state default                                                                 
  type CONFIGS_PIN (3)                                                          
  controlling device ahb:apb:pinctrl at fc038000                                   
  pin PA18                                                                      
  config 00010003                                                               
                                                                                
                                                  
Doing as you propose, I assume the result should be:                            
                                                                                
  # cat /sys/kernel/debug/pinctrl/ahb\:apb\:pinctrl at fc038000/pinmux-pins        
  pin 17 (PA17): (MUX UNCLAIMED) (GPIO UNCLAIMED)                               
  pin 18 (PA18): b0000000.sdio-host (GPIO UNCLAIMED) function E group PA18
  pin 19 (PA19): b0000000.sdio-host (GPIO UNCLAIMED) function E group PA19

  # cat /sys/kernel/debug/pinctrl/pinctrl-maps
  Pinctrl maps:

  device b0000000.sdio-host
  state default
  type MUX_GROUP (2)
  controlling device ahb:apb:pinctrl at fc038000
  group PA28
  function E

  device b0000000.sdio-host
  state default
  type CONFIGS_PIN (3)
  controlling device ahb:apb:pinctrl at fc038000
  pin PA28
  config 00010003
                                                                                
  device b0000000.sdio-host
  state default
  type MUX_GROUP (2)
  controlling device ahb:apb:pinctrl at fc038000
  group PA18
  function E

  device b0000000.sdio-host
  state default
  type CONFIGS_PIN (3)
  controlling device ahb:apb:pinctrl at fc038000
  pin PA18
  config 00010003

I think it is more difficult to understand what is done here.


I have sent patches months ago trying to improve things by having
something more flexible. I don't think I introduce too big changes.
The only answers I got were from people thinking that pinctrl framework
conception is not good to fit all kind of controllers. I re-sent the
patch series to gain more expose and have no  answer...

I wanted to use as much as possible the generic stuff we have in order
to not add a new "custom" implementation. If it is such a big deal to
do these changes because you (or other people) think that we can use
it as is to describe our pinmux/pinconf configuration then I can
switch to a custom implementation too and not use the pinconf generic
dt_node_to_map. I think this solution is not encouraged by Linus who
prefers to cling the generic infrastructure, isn'it? This is exactly
why I took this approach.


FYI: some context about these patches:

The RFC I send long time ago:
http://www.spinics.net/lists/linux-gpio/msg05198.html

My second attempt:
http://comments.gmane.org/gmane.linux.kernel.gpio/7767

It is not the first time, there are discussions about it. Sascha sent a
patch which fits part of my needs:
http://lists.infradead.org/pipermail/linux-arm-kernel/2015-January/318452.html

And it seems some controllers use this approach:
http://lists.infradead.org/pipermail/linux-arm-kernel/2015-January/318452.html


Regards

Ludovic
