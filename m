From: tomeu.vizoso@collabora.com (Tomeu Vizoso)
Date: Mon, 21 Sep 2015 16:08:33 +0200
Subject: [PATCH v5 07/23] regulator: core: Remove regulator_list
In-Reply-To: <20150920203242.GM21084@n2100.arm.linux.org.uk>
References: <1442494637-3674-1-git-send-email-tomeu.vizoso@collabora.com>
 <1442494637-3674-8-git-send-email-tomeu.vizoso@collabora.com>
 <20150919150129.GR12027@sirena.org.uk>
 <20150920203242.GM21084@n2100.arm.linux.org.uk>
Message-ID: <CAAObsKCK57=98oq0r11stZjkvAEdvCLOsjLkrjC80whgg1Q20w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20 September 2015 at 22:32, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Sat, Sep 19, 2015 at 08:01:29AM -0700, Mark Brown wrote:
>> On Thu, Sep 17, 2015 at 02:57:01PM +0200, Tomeu Vizoso wrote:
>> > As we are already registering a device with regulator_class for each
>> > regulator device, regulator_list is redundant and can be replaced with
>> > calls to class_find_device() and class_for_each_device().
>>
>> This appears to leak references to the struct devices returned by
>> class_find_device() - it takes a reference before it returns so any
>> device found using class_find_device() needs to be released with
>> put_device() and I don't see any new put_device() calls in here.
>
> When I've been fiding exactly that kind of bug in the PHY code, I've
> been adding comments to the docbook function header detailing the
> requirement to balance the reference.  IMHO, this is a good idea,
> because the more places that get it with these APIs, the more likely
> people are to potentially read it.
>
> The comment I've been putting in the phy code is:
>
>  * If successful, returns a pointer to the phy_device with the embedded
>  * struct device refcount incremented by one, or NULL on failure. The
>  * refcount must be dropped by calling phy_disconnect() or phy_detach().
>
> which even goes as far as telling people how they should be dropping
> the reference.  So there should be no excuse (ignorance is not an
> excuse for this!)

Thanks for the suggestion, I have gone with it.

Regards,

Tomeu

> --
> FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
> according to speedtest.net.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
