From: frowand.list@gmail.com (Frank Rowand)
Date: Thu, 19 Mar 2015 10:02:51 -0700
Subject: [patch 2/7] dt: dtb version: document chosen/dtb-info node binding
In-Reply-To: <20150319134910.GF18473@leverpostej>
References: <550A42AC.8060104@gmail.com> <550A4382.4030209@gmail.com>
 <20150319134910.GF18473@leverpostej>
Message-ID: <550B013B.1060002@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3/19/2015 6:49 AM, Mark Rutland wrote:
> On Thu, Mar 19, 2015 at 03:33:22AM +0000, Frank Rowand wrote:
>> From: Frank Rowand <frank.rowand@sonymobile.com>
>>
>> Add /chosen/dtb-node binding.
> 
> Why? It doesn't matter what the cover says, the commit message should
> have a rationale.
> 
> Who needs this information, and when do they need it?
> 
> Why is the existing information insufficient?

Will update and add better information.

> 
>> Signed-off-by: Frank Rowand <frank.rowand@sonymobile.com>
>> ---
>>  Documentation/devicetree/bindings/chosen.txt |   37 +++++++++++
>>
>> Index: b/Documentation/devicetree/bindings/chosen.txt
>> ===================================================================
>> --- a/Documentation/devicetree/bindings/chosen.txt
>> +++ b/Documentation/devicetree/bindings/chosen.txt
>> @@ -46,6 +46,43 @@ on PowerPC "stdout" if "stdout-path" is
>>  should only use the "stdout-path" property.
>>  
>>  
>> +dtb-info node
>> +----------------
>> +
>> +Information that describes where the device tree blob (DTB) came from and the
>> +environment it was created in.
>> +
>> +This node is normally created by including arch/arm/boot/dts/skeleton.dtsi,
>> +which includes include/dt-bindings/version.dtsi.
>> +
>> +Properties:
>> +
>> +version
>> +	The version of the DTB.  This is analagous to the linux kernel version.
>> +
>> +	This is a format free field intended for human consumption.  User space
>> +	programs should not have any expections about this property.
> 
> I doubt that this would stay the case for long were this property added.
> 
>> +	The DTB number in this property is incremented each time a make that
>> +	creates one or more DTBs is invoked.  If the make creates multiple
>> +	DTBs then this number is only incremented once.
>> +
>> +	The DTB number is stored in file .version_dtb.
> 
> This is irrelevant to the binding, and as you mention above, you can
> make no expectations about this property.

OK, I'll remove the reference to .version_dtb.

> 
> I'm not sure I see the point in adding a property which is not
> well-defined and not guarnateed to be in any way stable.

This binding is kind of an odd ball to me.  It is clearly _not_ describing
hardware, which is really the central point of the dtb.  But the chosen
node is allowed to cover policy things like the boot command line.

So I would encourage a slightly unusual mind set when reviewing this
binding (not that I really know what that mind set is!).

The answer to the specific question of why add a "not well-defined"
binding is the same answer as to why have a kernel version string.
There was a proposal to remove the kernel version string and that
was quickly dropped.

I should have written more about why this is useful.

This binding provides the provenance of the DTB.  What source (and
version of the source) and version of the compiler (dtc) was used
to make the DTB.

If I want to debug DTB related issues, read the source that was used
to create the DTB, or slightly modify the DTB - where is the source
and what is the version of it in the source control system.

When building and installing a DTB, did the version that I wanted to
install on the target actually get on the target.

> 
>> +
>> +version-linux
>> +	The version of the linux kernel most recently built in the source
>> +	control system that contains the source used to build the DTB.
>> +
>> +	The linux kernel version number is not incremented for a make that
>> +	creates a DTB.
> 
> ...so if I build a DTB outside of a linux source tree I don't get to
> describe that?

I will make the name more generic.

> 
>> +dtb-path
>> +	The build directory relative path of the DTB.
>> +
>> +dts-path
>> +	The absolute path of the .dts file compiled to create the DTB.
> 
> Why do you need the DTB path?

Paranoia.  Even if not probable, one could build different DTBs from
the same .dts.

> 
> Why do these differ w.r.t. absolute/relative?

Those are the forms of the path that are present in the build
system.  If there is a good reason to change one of them to the
other form, I could add the extra complexity to massage the path.

> 
> Why would you _ever_ need an absolute path!?

The absolute path tells you which source repository contained the source.

> 
> Mark.
> 
