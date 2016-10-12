From: ahaslam@baylibre.com (Axel Haslam)
Date: Wed, 12 Oct 2016 17:01:52 +0200
Subject: [PATCH/RFT 07/12] USB: ohci-da8xx: Request gpios and handle
 interrupt in the driver
In-Reply-To: <22f1532a-b651-3330-b2ce-9a64a35c85af@lechnology.com>
References: <1475858577-10366-1-git-send-email-ahaslam@baylibre.com>
 <1475858577-10366-8-git-send-email-ahaslam@baylibre.com>
 <22f1532a-b651-3330-b2ce-9a64a35c85af@lechnology.com>
Message-ID: <CAKXjFTMO_tCzLxc5wznrW_g6rxMYT8jBgHCtiFfpHq_6M=RZWA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi David

On Tue, Oct 11, 2016 at 1:18 AM, David Lechner <david@lechnology.com> wrote:
> On 10/07/2016 11:42 AM, ahaslam at baylibre.com wrote:
>>
>> From: Axel Haslam <ahaslam@baylibre.com>
>>
>> Currently requesting the vbus and overcurrent gpio is handled on
>> the board specific file. But this does not play well moving to
>> device tree.
>>
>> In preparation to migrate to a device tree boot, handle requesting
>> gpios and overcurrent interrupt on the usb driver itself, thus avoiding
>> callbacks to arch/mach*
>>
>
> Instead of using gpios, it seems like it would be better to use a regulator
> here. I don't know of any real-life cases, but who is to say someone
> not design a board that uses a regulator controlled by I2C instead of gpios
> or something like that.
>
> Then, boards that don't have gpios can just use a fixed regulator (or you
> can make the regulator optional). Using a regulator would also allow users
> to decide how to respond to overcurrent events (by supplying their own
> regulator driver) instead of the behavior being dictated by the ohci driver.


I  agree that we should use a regulator for the vbus power.
i will make that change.  However, im not so sure about using the
regulator for the overcurrent handling. There seems to be no other
driver doing this, and as you mention, we would need to change the regulator
framework, which might not be justifiable. I think there is not another way
to handle the over current notification other than powering the port off.

>
> In my particular area of interest (LEGO MINDSTORMS EV3), the 5V (hardware)
> regulator for VBUS does use gpios, but the 5V is also shared with the LEGO
> input and output ports. So what I would ultimately like to be able to do is
> have userspace notified of an overcurrent event and let userspace decided
> when to turn the vbus back on. For example, someone might plug something
> into one of the LEGO input or output ports that causes a short circuit. I
> would like to display a notification to the user and wait for them to
> correct the problem and then press a button to turn the power back on.
>

how about using regulator for vbus, but keeping gpio for overcurrent
notifications?

For the usersapce handling you describe above, maybe we should be able to
listen for an usb overcurrent uevent in userspace? it seems this
question was asked
a couple of years back[1], but im not sure what the conclusion was. In any case,
we could have DT and non-DT based ohci-da8xx working,
And could work on a uevent notification for the scenario you describe
above which
i think is not specific to the ohci-da8xx.

[1]http://linux-usb.vger.kernel.narkive.com/SjcUB5hk/how-best-to-get-over-current-notification-to-user-application


Regards
Axel

> This will require some modifications to the regulator subsystem though. I
> actually started work on this a while back, but haven't had the time to
> pursue it any farther.
>
> Here are my WIP patches in case there is any interest:
> *
> https://github.com/dlech/ev3dev-kernel/commit/541a42b3b8ed639e95bbc835df3292f80190c789
> *
> https://github.com/dlech/ev3dev-kernel/commit/2ba99b1ad6a06c944dd33a073f54044e71b75ae6
> *
> https://github.com/dlech/ev3dev-kernel/commit/cdb03caa50e64931d4f2836c648739aa4385ed3b
> *
> https://github.com/dlech/ev3dev-kernel/commit/9d6b50cde34b51309c74d97c26b1430c7ff6aa0f
