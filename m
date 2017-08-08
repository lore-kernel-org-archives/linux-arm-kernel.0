From: sudeep.holla@arm.com (Sudeep Holla)
Date: Tue, 8 Aug 2017 10:29:31 +0100
Subject: [PATCH v2 03/18] firmware: arm_scmi: add basic driver
 infrastructure for SCMI
In-Reply-To: <CABb+yY0DQ1H8Apb6PoqKg-HrTfbyxShum9YtJit96T4Yo9+zrQ@mail.gmail.com>
References: <1501857104-11279-1-git-send-email-sudeep.holla@arm.com>
 <1501857104-11279-4-git-send-email-sudeep.holla@arm.com>
 <CABb+yY0DQ1H8Apb6PoqKg-HrTfbyxShum9YtJit96T4Yo9+zrQ@mail.gmail.com>
Message-ID: <3279524c-d3e5-fe0f-ba7d-f715bfdcad9c@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 08/08/17 03:46, Jassi Brar wrote:
> On Fri, Aug 4, 2017 at 8:01 PM, Sudeep Holla <sudeep.holla@arm.com> wrote:
> 
> ....
>> +int scmi_do_xfer(const struct scmi_handle *handle, struct scmi_xfer *xfer)
>> +{
>> +       int ret;
>> +       int timeout;
>> +       struct scmi_info *info = handle_to_scmi_info(handle);
>> +       struct device *dev = info->dev;
>> +
>> +       ret = mbox_send_message(info->tx_chan, xfer);
>>
> NAK
> 
> This is still not fixed. For the reasons mentioned many times like
> here...   https://lkml.org/lkml/2017/7/7/465
> 

Since SCPI and SCMI are based on doorbell designs like ACPI PCC, they
can't send any data as all the data are part of shared memory.

What data needs to be sent from SCPI/SCMI as part of mbox_send_message
in your opinion ? I can't think of any generic way to form this data.

It's not possible to generalize that and SCPI/SCMI's transport is
specifically designed in that way to avoid any kind of dependency
on the mailbox hardware so that the protocol can be generic exactly like
ACPI PCC.

I understand your concern on how existing mailbox controllers work with
it. They can't as they stand today as they expect some specific data
based on the hardware or the protocol they support on it.

One option to deal with this is to have a generic DT based doorbell kind
of controller driver but I am not sure if we can define register level
bindings like ACPI PCC.

Or we teach them to ignore the data if it's not present. I don't like
the idea of adding shim layer for each of the controller as each one
expect different format and more over SCPI/SCMI doesn't even require it
to support SCMI on those mailbox controllers. That may end up with 2x
drivers(one actual driver and and another shim layer for it)

-- 
Regards,
Sudeep
