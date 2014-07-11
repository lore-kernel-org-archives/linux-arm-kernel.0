From: t.figa@samsung.com (Tomasz Figa)
Date: Fri, 11 Jul 2014 11:43:22 +0200
Subject: [PATCH v7 08/24] mfd: max77686: Add Dynamic Voltage Scaling (DVS)
 support
In-Reply-To: <53BF41C8.4080304@collabora.co.uk>
References: <1404505467-26526-1-git-send-email-javier.martinez@collabora.co.uk>
 <1404505467-26526-9-git-send-email-javier.martinez@collabora.co.uk>
 <CADGdYn6tyTBZOjZH8JBUVMJ1kh-tht=tkU4tA+oM=PbfTYkqGw@mail.gmail.com>
 <53BF41C8.4080304@collabora.co.uk>
Message-ID: <53BFB1BA.6030108@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Javier,

On 11.07.2014 03:45, Javier Martinez Canillas wrote:
> On 07/10/2014 11:59 AM, amit daniel kachhap wrote:
>> On Sat, Jul 5, 2014 at 1:54 AM, Javier Martinez Canillas
>> <javier.martinez@collabora.co.uk> wrote:

[snip]

>>> @@ -111,6 +223,13 @@ static struct max77686_platform_data *max77686_i2c_parse_dt_pdata(struct device
>>>                 return NULL;
>>>
>>>         dev->platform_data = pd;
>>> +
>>> +       /* Read default index and ignore errors, since default is 0 */
>>> +       of_property_read_u32(np, "max77686,pmic-buck-default-dvs-idx",
>>> +                            &pd->buck_default_idx);
>> Any error checking code here. Say if pmic-buck-default-dvs-idx exceed 8?
> 
> I'm not a DT expert but AFAIK the kernel should expect the data in a FDT to be
> correct and should not validate it on runtime. There is work-in-progress to add
> a proper schema checking for DTS to the dtc so on build time it can be validated
> that a DTS is valid.
> 
> AFAIU the only thing that the kernel should check is if a required property does
> not exist.

I'd disagree on this.

IMHO schema (if it progresses further, as unfortunately I can't find
time to dedicate to it and looks like it's similar for other people that
used to be involved) should be focused on structural checks, i.e. proper
layout of nodes and properties, basic data types and so, to figure out
common errors earlier than at boot-up time.

On kernel side this should be treated in the same way as platform data.
I agree that some existing drivers do little to validate incoming data,
but I believe it is a good practice to validate things that the driver
has no control over, especially when it's about a PMIC, when invalid
data can have quite serious effects and detecting even some of them
(e.g. value to big, which would overflow in target bit field) might
prevent a failure.

Best regards,
Tomasz
