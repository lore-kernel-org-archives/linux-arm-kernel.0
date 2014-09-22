From: robherring2@gmail.com (Rob Herring)
Date: Mon, 22 Sep 2014 17:11:29 -0500
Subject: [PATCH v11 08/10] OF: PCI: Add support for parsing PCI host
 bridge resources from DT
In-Reply-To: <20140922175505.GH1994@e106497-lin.cambridge.arm.com>
References: <1411003825-21521-1-git-send-email-Liviu.Dudau@arm.com>
 <1411003825-21521-9-git-send-email-Liviu.Dudau@arm.com>
 <20140919210610.GI19374@google.com> <541CCA36.8010606@gmail.com>
 <20140922175505.GH1994@e106497-lin.cambridge.arm.com>
Message-ID: <CAL_JsqKw-KSdDGgFuHytONKA-53-z+QtQd+0JzLhW+Xs0+knsQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 22, 2014 at 12:55 PM, Liviu Dudau <Liviu.Dudau@arm.com> wrote:
> On Sat, Sep 20, 2014 at 01:28:38AM +0100, Rob Herring wrote:
>> On 09/19/2014 04:06 PM, Bjorn Helgaas wrote:
>> > On Thu, Sep 18, 2014 at 02:30:23AM +0100, Liviu Dudau wrote:
>> >> Provide a function to parse the PCI DT ranges that can be used to
>> >> create a pci_host_bridge structure together with its associated
>> >> bus.
>> >>
>> >> Cc: Bjorn Helgaas <bhelgaas@google.com>
>> >> Cc: Arnd Bergmann <arnd@arndb.de>
>> >> Cc: Grant Likely <grant.likely@linaro.org>
>> >> Cc: Rob Herring <robh+dt@kernel.org>
>> >> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> >> Signed-off-by: Liviu Dudau <Liviu.Dudau@arm.com>
>> >> ---
>>
>> [...]
>>
>> >> +int of_pci_get_host_bridge_resources(struct device_node *dev,
>> >> +                  unsigned char busno, unsigned char bus_max,
>> >> +                  struct list_head *resources, resource_size_t *io_base)
>> >> +{
>> >> +  struct resource *res;
>> >> +  struct resource *bus_range;
>> >> +  struct of_pci_range range;
>> >> +  struct of_pci_range_parser parser;
>> >> +  char range_type[4];
>> >> +  int err;
>> >> +
>> >> +  if (!io_base)
>> >> +          return -EINVAL;
>> >> +  *io_base = OF_BAD_ADDR;
>> >> +
>> >> +  bus_range = kzalloc(sizeof(*bus_range), GFP_KERNEL);
>>
>> This function does a lot of kalloc's but there is not an easy way to
>> undo those allocations. Hot unplug of a host bridge or probe error
>> handling would leak memory.
>>
>> You could pass in struct device and use the devm_ variant (also
>> addressing Bjorn's comment), but not having an uninit/remove function
>> make what clean-up drivers have to do error prone. For example, on
>> uninit a driver needs to call pci_free_resource_list.
>
> If the function fails to parse the ranges for whatever reason it will
> call pci_free_resource_list on the resources that have been added already
> and it will clean up. If it is successful, then it is the job of the caller
> to free the list, as mentioned in the comment associated with the function.
>
> The reason why I am reluctant to use devm_ here is that the ranges are only
> parsed here, no filtering is applied. Architectures and/or host bridge
> drivers can/could impose additional restrictions to the list before passing
> it to pci_scan_root_bus() for example.

Okay, as long as the caller has a single clean-up responsibility, I
guess it is fine.

Rob
