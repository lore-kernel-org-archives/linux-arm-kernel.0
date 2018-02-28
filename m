From: robin.murphy@arm.com (Robin Murphy)
Date: Wed, 28 Feb 2018 18:32:15 +0000
Subject: [PATCH 0/3] STM32 Extended TrustZone Protection driver
In-Reply-To: <20180228175303.h7qm3zylmfsitmwn@lakrids.cambridge.arm.com>
References: <20180227140926.22996-1-benjamin.gaignard@st.com>
 <20180227171124.h2yjhicmlfrwr4nh@lakrids.cambridge.arm.com>
 <CA+M3ks6qV_pGdE6mr3n7TiY9VhbqEkrdH6tN=8e-A=oa4UbDHw@mail.gmail.com>
 <11c3ceb2-8b8d-de59-a0be-0777a42f63a7@arm.com>
 <CA+M3ks5qR++8Vwwk8=5Oh6DBdT9NF3ysqfjayq4Gze-oke8Ayg@mail.gmail.com>
 <20180228175303.h7qm3zylmfsitmwn@lakrids.cambridge.arm.com>
Message-ID: <09775cf5-ba70-bef6-6196-5f16fd0dc08b@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28/02/18 17:53, Mark Rutland wrote:
[...]
>> It is not about to "check" the DT but if Linux could get access to the
>> hardware.  Hardware block assignment to secure or non-secure world
>> could change at runtime for example I2C block could be manage by
>> secure OS for a trusted application and when it have finish "release"
>> the it for Linux.
> 
> The driver does not do this today. It probe the HW once during early
> boot, then aborts driver probes. It provides no provision for dynamic
> assignment.
> 
> Is this something you plan to implement? How will the secure world
> notify the non-secure world of its intent to manage a device, or
> vice-versa?

Note that this is another thing which in general already happens - 
control of (and correspondingly, hardware access to) things like display 
engines and video decoders can get transferred between Linux (well, 
Android at least) and a trusted OS. You need communication and 
cooperation between the two sides via channels like tee-supplicant to 
make it usable, though, at which point the fact that this ETZPC provides 
non-secure-visible status unlike other TZASCs is rather superfluous - if 
the secure side could just blindly take ownership of the I2C block in 
response to some event, while the Linux I2C driver is in the middle of 
its own transfer, a status bit in a register somewhere else isn't going 
to be much help overall.

>> I don't think that could be done by changing DT.
>>
>> I think that dhecking hardware blocks status bits before probe them is
>> also more robust than let
>> each driver discover at probe time that it hardware isn't responding.
> 
> I don't follow. Robin and I suggest that gets encoded in the DT, which
> is *more* efficient than having each driver probe the DT, begin probing,
> then abort via the notifier.
> 
> This really seems like something that should be done *prior* to entering
> Linux.

Indeed; the DT by nature describes the initial state of the system at 
the point that Linux takes control, and thus it really *should* reflect 
whatever the current ETZPC configuration is. Note what DTSpec actually says:

     "disabled" 	

     Indicates that the device is not presently operational, but it might
     become operational in the future (for example, something is not
     plugged in, or switched off).

     Refer to the device binding for details on what disabled means for a
     given device.

The fact that the current behaviour of our OF platform code doesn't 
really respect that last point and makes it tricky to bring 
initially-unavailable devices to life later is a separate issue.

Robin.
