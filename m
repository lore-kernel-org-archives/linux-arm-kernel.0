From: khilman@ti.com (Kevin Hilman)
Date: Thu, 10 Mar 2011 10:03:09 -0800
Subject: [PATCH 2/2] OMAP: PM: implement devices constraints APIs
In-Reply-To: <AANLkTikN=1TLGoqLE4OBNdq4DDHAimGURA9ejy7TOZm7@mail.gmail.com>
	(Jean Pihet's message of "Thu, 10 Mar 2011 11:03:37 +0100")
References: <1299250375-26134-1-git-send-email-j-pihet@ti.com>
	<1299698346-2768-1-git-send-email-j-pihet@ti.com>
	<alpine.DEB.2.00.1103091943550.15132@utopia.booyaka.com>
	<AANLkTikN=1TLGoqLE4OBNdq4DDHAimGURA9ejy7TOZm7@mail.gmail.com>
Message-ID: <87oc5idfaa.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jean Pihet <jean.pihet@newoldbits.com> writes:

[...]
>> Please create two different functions,
>> omap_device_set_max_dev_wakeup_lat() and
>> omap_device_set_min_bus_tput(). ?Documentation/CodingStyle chapter 6.
>>

> It has been agreed (in weekly calls) to have two functions at the OMAP
> PM level but only one function with a class parameter at the
> omap_device level. This allows easier maintenance and clean-up later.
> Kevin, is that corrcet?

Yes, that is my preference (but Paul is the maintainer of these layers,
so he has the final say.)  What I would like to see is a more generic
API at the omap_device level which can easily be extended to handle new
constraints (by adding a new 'class'), without having to grow the API
each time.

That being said, you can still create the two functions that Paul
mentioned above and just have the generic function call those based on
class.

The only question then is which interface the drivers will eventually
use.  I much prefer keeping the driver interface to a simple set of add
& remove constraint functions where the type is determined by class:

Today we have:

 - max wakeup latency
 - min bus througput

but eventually we may also want

 - min frequency
 - max frequency (thermal)
 - etc.

Kevin
