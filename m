From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Tue, 01 Apr 2014 16:23:12 +0200
Subject: [PATCH RFC v4 2/2] clk: Add handling of clk parent and rate
 assigned from DT
In-Reply-To: <533ABCEC.8040701@codethink.co.uk>
References: <1396284116-19178-1-git-send-email-s.nawrocki@samsung.com>
 <1396284116-19178-3-git-send-email-s.nawrocki@samsung.com>
 <20140331200620.GA13881@kroah.com> <533ABCEC.8040701@codethink.co.uk>
Message-ID: <533ACBD0.8030209@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/04/14 15:19, Ben Dooks wrote:
> On 31/03/14 21:06, Greg KH wrote:
>> > On Mon, Mar 31, 2014 at 06:41:56PM +0200, Sylwester Nawrocki wrote:
[...]
>> > I don't understand why you need the driver core to initialize this one
>> > type of thing?  That should be in a driver, or in a class, or at worse
>> > case, the platform code.
>> >
>> > What makes clocks so "unique" here?

The reason I put it in the driver core was mainly to avoid having many
drivers doing same call to this initialization function.
I was considering moving it to the bus code, still there are several
buses for which it would need to be repeated.

Maybe really_probe() is not a best place to put this, nonetheless
the requirements I could list were:

 1. not involving individual drivers,
 2. have such an initialization call done for all devices, irrespective
    of Linux bus or class type,
 3. Handle errors properly, e.g. defer driver probing if a clock for
   a device is not yet available.

One advantage I could see from making the call from within a device
driver is that a device could keep using the common DT bindings and
replace the common initialization function with a private one, if
there is a need for some quirks handled for a device. With approach
as in this patch it's difficult to override the default behaviour.
However then there is a question whether we strive for the clocks
management to be possibly kept away from device drivers.

> I suppose the issue here is that a lot of drivers currently use
> clocks and a number of systems have badly setup default clock trees
> at start time.
> 
> Mark Brown and others have argued that the management of clocks which
> is common to all devices should not live in the driver.

True, motivation behind this patch series was also replacing custom
code in multiple drivers doing similar clock rate or parent setting
by a common code, using standardized DT binding.

--
Thanks,
Sylwester
