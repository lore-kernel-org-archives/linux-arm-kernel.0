From: martin@sperl.org (Martin Sperl)
Date: Thu, 11 Feb 2016 00:19:39 +0100
Subject: [PATCH 3/4] spi: bcm2835aux: set up spi-mode before asserting
 cs-gpio
In-Reply-To: <2743238.b2UJKq0efN@chaos-desktop>
References: <1455041435-8015-1-git-send-email-stephanolbrich@gmx.de>
 <878u2s2xym.fsf@eliezer.anholt.net> <20160210190204.GD13270@sirena.org.uk>
 <2743238.b2UJKq0efN@chaos-desktop>
Message-ID: <7B5ED5ED-EF09-4D44-8989-1BBCD7C01463@sperl.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> On 10.02.2016, at 21:26, Stephan Olbrich <stephanolbrich@gmx.de> wrote:
> 
> Am Wednesday 10 February 2016, 19:02:04 schrieb Mark Brown:
>> On Wed, Feb 10, 2016 at 10:59:29AM -0800, Eric Anholt wrote:
>>> Oops, this makes more sense now.  Subject even mentioned gpio, and a
>>> GPIO CS must be getting set around the transfer_one call.  I'll be ready
>>> to send an r-b for a v2 with the speed update bug fixed (unless transfer
>>> speeds are guaranteed to be constant between a prepare and unprepare).
>> 
>> No guarantee that they'll not change, especially in a situation where we
>> have two devices on different speeds on a bus working at the same time.
> Are you saying, that between a prepare and unprepare there could be transfers 
> for another device? Then all the clock setting couldn't be done in prepare 
> either.
> Apart from that, if two transfers in the same message are not guarantied to 
> have the same speed, this still needs to be fixed. I'll roll a v2.

Prepare/unprepare is always called when processing an spi message.
there is never a phase where two spi_messages are prepared concurrently
for the same spi bus.

See the implementation of __spi_pump_messages

The sequence for processing is:
* master->prepare_hardware
* master->prepare_message
* spi_map_message
* master->transfer_one_message
  * spi_set_cs(true)
  at end of message:
  * spi_finalize_current_message
    * spi_set_cs(false)
    * master->unprepare_message 

So the use of prepare_message in this context is valid.

Otherwise we would need to add an additional method to setup
polarity/cs prior to spi_set_cs(true).

Ciao,
	Martin
