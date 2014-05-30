From: hdoyu@nvidia.com (Hiroshi Doyu)
Date: Fri, 30 May 2014 22:29:13 +0300
Subject: [PATCH v2] devicetree: Add generic IOMMU device tree bindings
In-Reply-To: <4545972.cM7IP1qTXQ@wuerfel>
References: <1400877218-4113-1-git-send-email-thierry.reding@gmail.com>
 <CAL_JsqKumG1PSFoVfeGpLLG+MjXFeF4aUjun=vv1BJpaxk0Byg@mail.gmail.com>
 <4545972.cM7IP1qTXQ@wuerfel>
Message-ID: <87tx87rrp2.fsf@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Arnd Bergmann <arnd@arndb.de> writes:

>> > +Multiple-master IOMMU:
>> > +----------------------
>> > +
>> > +       iommu {
>> > +               /* the specifier represents the ID of the master */
>> > +               #address-cells = <1>;
>> > +               #size-cells = <0>;
>> > +       };
>> > +
>> > +       master {
>> > +               /* device has master ID 42 in the IOMMU */
>> > +               iommus = <&/iommu 42>;
>> > +       };
>> 
>> Presumably the ID would be the streamID on ARM's SMMU. How would a
>> master with 8 streamIDs be described? This is what Calxeda midway has
>> for SATA and I would expect that to be somewhat common. Either you
>> need some ID masking or you'll have lots of duplication when you have
>> windows.
>
> I don't understand the problem. If you have stream IDs 0 through 7,
> you would have
>
> 	master at a {
> 		...
> 		iommus = <&smmu 0>;
> 	};
>
> 	master at b {
> 		...
> 		iommus = <&smmu 1;
> 	};
>
> 	...
>
> 	master at 12 {
> 		...
> 		iommus = <&smmu 7;
> 	};
>
> and you don't need a window at all. Why would you need a mask of
> some sort?

IIUC the original problem, "a master with 8 streamIDs" means something
like below, where some devices have multiple IDs but some have a
single. A sinle #address-cells cannot afford those 2 masters at once.

       iommu {
               /* the specifier represents the ID of the master */
               #address-cells = <1>;
               #size-cells = <0>;
       };

 	master at a {
 		...
 		iommus = <&smmu 1 2 3>; # 3 IDs
 	};

 	master at b {
 		...
 		iommus = <&smmu 4>;     # 1 ID
 	};

Tegra,SMMU has a similar problem and we have used a fixed size bitmap(64
bit) to afford 64 stream IDs so that a single device can hold multiple
IDs. If we apply the same bitmap to the above exmaple:

       iommu {
               /* the specifier represents the ID of the master */
               #address-cells = <1>;
               #size-cells = <0>;
       };

 	master at a {
 		...
 		iommus = <&smmu (BIT(1) | BIT(2) | BIT(3))>; # IDs 1 2 3
 	};

 	master at b {
 		...
 		iommus = <&smmu BIT(4)>;     # ID 4
 	};

The disadvantage of this is that this limits the max number of streamIDs
to support. If # of streamID is increased later more than 64, this
format cannot cover any more. You have to predict the max # of streamIDs
in advance if steamID is statically assigned.
