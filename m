From: zajec5@gmail.com (=?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?=)
Date: Mon, 11 Apr 2011 23:36:39 +0200
Subject: [RFC][PATCH V3] axi: add AXI bus driver
In-Reply-To: <20110411212513.GA17809@kroah.com>
References: <1302557114-7880-1-git-send-email-zajec5@gmail.com>
	<20110411210631.GA28559@kroah.com>
	<BANLkTim155YxMUVJ=pmVs-rNhkovGPG6OQ@mail.gmail.com>
	<20110411212513.GA17809@kroah.com>
Message-ID: <BANLkTingqXAWTeOhcL6ER0UJfEdQF5Bo2A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/4/11 Greg KH <greg@kroah.com>:
> On Mon, Apr 11, 2011 at 11:19:13PM +0200, Rafa? Mi?ecki wrote:
>> 2011/4/11 Greg KH <greg@kroah.com>:
>> > On Mon, Apr 11, 2011 at 11:25:14PM +0200, Rafa? Mi?ecki wrote:
>> >> +static void axi_release_core_dev(struct device *dev)
>> >> +{
>> >> + ? ? /* Silent lack-of-release warning */
>> >> +}
>> >
>> > Ok, WTF!!!!
>>
>> Thank you for your kindly words. It's much more enjoyable to work on
>> kernel that way. I definitely made that on purpose.
>
> I can't tell if you are kidding or not.

That was 100% irony. I swear I don't enjoy publishing bad code and
getting such a comment.


> Please read the documentation for how to do this properly. ?I find it
> really hard to believe that you wrote that comment instead of putting in
> the 2 lines of code required for this function.
>
> Especially as-it-is, your code does not work properly and leaks memory
> badly. ?Why would you do that on purpose?

I tried to read some documentation about this.

1) driver-mode/device.txt says only that:
> Callback to free the device after all references have
> gone away. This should be set by the allocator of the
> device (i.e. the bus driver that discovered the device).
I *really* do not know how my driver should "free" core on AXI bus.

2) LDD3 says:
> The method is called when the last reference to the device is removed; it is called
> from the embedded kobject?s release method. All device structures registered with
> the core must have a release method, or the kernel prints out scary complaints.
Well, I do not register any structs for AXI core.

3) Example code from LDD3:
static void ldd_bus_release(struct device *dev)
{
printk(KERN_DEBUG "lddbus release\n");
}
Yeah, that's what I did...

4) SSB in it's ssb_release_dev just calls kfree on struct that was
allocated when registering drivers. *I do not* allocate such a struct,
so I believe I do exactly the same memory leak as SSB does.


Can you spend 2 more minues in addition to commenting my ideas and
help me with writing that 2 lines I missed? Where do I leak memory in
my driver? Which struct should I kfree?

-- 
Rafa?
