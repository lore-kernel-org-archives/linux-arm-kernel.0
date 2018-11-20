From: eric@anholt.net (Eric Anholt)
Date: Tue, 20 Nov 2018 13:34:03 -0800
Subject: [PATCH 0/8] BCM2835 PM driver
In-Reply-To: <1299453058.112996.1542736171394@email.ionos.de>
References: <20181120172000.15102-1-eric@anholt.net>
 <1299453058.112996.1542736171394@email.ionos.de>
Message-ID: <87o9aj77sk.fsf@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Stefan Wahren <stefan.wahren@i2se.com> writes:

> Hi Eric,
>
>> Eric Anholt <eric@anholt.net> hat am 20. November 2018 um 18:19 geschrieben:
>> 
>> 
>> This series moves the BCM2835 WDT driver that controls a fraction of
>> the PM block out to soc/ and adds most of the rest of its
>> functionality.  My motivation has been to have V3D be functional
>> without firmware calls, probably improve its interactivity (since
>> we'll be able to power on/off without RPC to the firmware that may be
>> busy with other tasks), and (in a patch not submitted in this series)
>> extend its binding to use the reset controller instead of trying to
>> reset by toggling its power domain.
>> 
>> I've tested V3D with a few hours of running a V3D test, sleep(1) (to
>> trigger PM domain off); running a GPU hang job (to trigger reset);
>> sleep(1).  The non-hanging success-case job always passed, and dmesg
>> had no complaints from bcm2835-pm.  The other power domains are not
>> tested, but I've done my best.
>> 
>> This series will probably also be of interest to the
>> https://github.com/christinaa/rpi-open-firmware project for enabling USB.
>> 
>
> apologize to give you my feedback after you send out the series.
>
> I know you won't be happy about it, but i think we need a little more
> complex but future proof solution for this power driver. According to
> the register definition of the PM block, we have multiple functions
> here (power domains, watchdog, pads/pinctrl, ...). Since this is
> common for ARM SoCs there is a subsystem called mfd (multi function
> device) [1] to abstract all resources of the IP block.
>
> This has the advantage that we don't need a monolithic driver which
> takes care of all functions.

I consider your "advantage" to be a disadvantage.  By forcing the split,
you end up having more driver files to manage, more platform devices,
and more error-prone code to get the resources from the parent down into
the client.  It feels like writing software for the sake of writing
software, rather than solving a concrete problem.

My original series:

 10 files changed, 951 insertions(+), 273 deletions(-)

The MFD series:

 12 files changed, 882 insertions(+), 25 deletions(-)
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 832 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181120/ac1f75fd/attachment.sig>
