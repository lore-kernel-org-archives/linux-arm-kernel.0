From: jonathar@broadcom.com (Jonathan Richardson)
Date: Wed, 13 May 2015 12:39:31 -0700
Subject: [PATCH 2/2] misc: Add initial Digital Timing Engine (DTE) driver
 for cygnus
In-Reply-To: <20150513152130.GB2065@localhost.localdomain>
References: <1429744923-2007-1-git-send-email-jonathar@broadcom.com>
 <1429744923-2007-3-git-send-email-jonathar@broadcom.com>
 <6346218.3x3hbSlxMs@wuerfel> <5543CD73.2030902@broadcom.com>
 <20150513152130.GB2065@localhost.localdomain>
Message-ID: <5553A873.1010803@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Richard, glad you retrieved our driver. Comments below.

On 15-05-13 08:21 AM, Richard Cochran wrote:
> On Fri, May 01, 2015 at 12:01:07PM -0700, Jonathan Richardson wrote:
>> The DTE creates timestamps of hardware based events such as GPIO, I2S
>> signals for audio, etc. It was also intended to provide 802.1AS / PTP
>> timestamps for network packets. The h/w has up to 32 "clients" -- the
>> hardware inputs into a timestamping engine. These clients are specific
>> to the chip the DTE is used on. For Cygnus you can see what they are in
>> our 'enum dte_client' from bcm_cygnus_dte.h.
> 
> These 32 channels should either go to kernel consumers (i2s audio) or,
> if there aren't any, to the generic PTP ioctl.
> 
>> The DTE timestamper creates timestamps based on the current clock wall
>> time.
> 
> What do you mean by "wall time"?  CLOCK_REALTIME?

It's just the incrementing local NCO time. Whatever the value of it is
is the timestamp time. When we add the timestamp to the s/w FIFO we
adjust the time to a reference time.

> 
>> When an event occurs it stores the timestamp in a h/w FIFO. Each
>> client also has a divider that can be set to control the rate that
>> timestamps are generated at by the timestamper and these are adjustable
>> at run time.
> 
> This does not make sense.  If you time stamp events, then the rate is
> determined by the events themselves.

The input events may occur at a rate greater than we want to generate
timestamps at. Maybe we need a better term than divider. The h/w sees x
input signals over x period of time and then samples the input signal at
a divided down period of time to limit the timestamp rate. Timestamp
input sample rate?

>  
>> It's a bit more than a PTP hardware clock on a NIC. It's a clock for PTP
>> plus timestamping 32 other hardware inputs that can be enabled at any
>> time with timestamps being generated at varying frequencies. As clients
>> are enabled that generate timestamps at higher frequencies, the
>> isochronous interrupt frequency needs to be increased so that overflows
>> in the the h/w and s/w FIFO's don't occur (this frequency could possibly
>> be automated instead of changing it manually as we currently do).
> 
> Yes, the driver should configure an appropriate rate automatically.

I was wrong. It can't. The DTE doesn't know anything about the inputs
hooked up to it nor the frequency of the input events. It needs to be
set by user space and the value can change at run time whenever we want
to change it.

> 
>> It looks like the driver could almost be a PTP driver instead of a char
>> driver controlled with ioctls. PTP does this already using
>> clock_gettime(), clock_settime(), clock_adjtime(). But we want to set
>> the frequency as well as adjust the clock and I don't see how that is
>> possible with the stripped down timex data passed to the driver from
>> ptp_clock_adjtime().
> 
> You can convert ppb into your time base using simple math.

Yes, this isn't a problem.

>  
>> We have the additional requirement of controlling multiple clients and
>> retrieving the timestamps, etc. The PTP driver allows for some control
>> of external time stamp channels already using 'n_ext_ts' in struct
>> ptp_clock_info. We could use that to enable clients and get timestamps,
>> but we also need to be able to change dividers for the clients at run
>> time if desired. It doesn't look like additional ioctls could be passed
>> to a PTP driver because ptp_ioctl() is the ioctl handler.
> 
> I don't see any need for use space to set dividers.  Let the driver do
> that.

See above.

Thanks.

> 
> Thanks,
> Richard
> 
