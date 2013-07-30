From: jonsmirl@gmail.com (jonsmirl at gmail.com)
Date: Tue, 30 Jul 2013 18:27:13 -0400
Subject: Defining schemas for Device Tree
In-Reply-To: <3852729.INDSeEDz7b@thinkpad>
References: <2469263.vMN09Q7Tzi@flatron>
	<3852729.INDSeEDz7b@thinkpad>
Message-ID: <CAKON4Oy3nvN4PajkOgZjYpPY_2XLry4qOvnVJ_KusYZeEdzpOw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 30, 2013 at 6:16 PM, Tomasz Figa <tomasz.figa@gmail.com> wrote:
> On Monday 29 of July 2013 02:21:52 Tomasz Figa wrote:
>> Hi,
>>
>> As promised I am starting a discussion about Device Tree schema. Let's
>> first shortly introduce the problem.
>>
>> Device Tree is a text-based data structure used to describe hardware. Its
>> main point is separation from kernel code, which has a lot of benefits,
>> but, at the moment, also a huge drawback - there is no verification of
>> device tree sources against defined bindings. All the dtc compiler does
>> currently are syntax checks - no semantic analysis is performed (except
>> some really basic things). What this means is that anybody can put
>> anything in their device tree and end up with the dts compiling fine only
>> to find out that something is wrong at boot time.
>>
>> Currently, device tree bindings are described in plain text documentation
>> files, which can not be considered a formal way of binding description.
>> While such documentation provides information for developers/users that
>> need to work with particular bindings, it can not be easily used as input
>> for validation of device tree sources. This means that we need to define a
>> more formal way of binding description, in other words - Device Tree
>> schema.
>>
>> To find a solution for this problem, we must first answer several
>> questions to determine a set of requirements we have to meet.
>>
>> a) What is a device tree binding?
>>
>> For our purposes, I will define a binding as internal format of some
>> device tree node, which can be matched using of_find_matching_node(). In
>> other words, key for a binding would be node name and/or value of
>> compatible property and/or node type. Value for a binding would be a list
>> of properties with their formats and/or subnodes with their bindings.
>
> Now as I think of it, there is one more thing that needs to be considered. Do
> we want the schemas to strictly specify available set of properties, warning
> about any unrecognized ones or just enforce checking of recognized properties
> (including presence of required ones)? Or maybe both, depending on some
> keyword or whatever?

I think it should warn about anything it doesn't recognize. That's the
hint for new DT developers to get on lkml and talk about their need
for a new attribute to be added to the master schema.

The device tree quirks should be put into a file which can both be
used at init time by the kernel or by the schema checker.  Now you can
feed those flash based DTB into the schema checker, apply the quirks
to them and ensure that your quirk code is working right. The
validator would take DTB input, apply the quirks, and write the DTS
output plus any errors it finds in the transformed tree.

So the dtc source in the kernel tree would build the quirks files into it.

>
>> b) What information should be specified in schemas? What level of
>>    granularity is required?
>>
>> For each property we need to have at least following data specified:
>>  - property name (or property name format, e.g. regex),
>>  - whether the property is mandatory or optional,
>>  - data type of value.
>>
>> As for now, I can think of following data types used in device trees:
>>  - boolean (i.e. without value),
>>  - array of strings (including single string),
>>  - array of u32 (including single u32),
>>  - specifier (aka phandle with args, including cases with 0 args),
>>  - variable-length cells (e.g. #address-cells of u32s).
>>
>> Some properties might require a combination of data types to be specified
>> or even an array of combinations, like interrupt-map property, which is an
>> array of entries consisting of:
>>  - #address-cells u32s,
>>  - #interrupt-cells u32s,
>>  - specifier (phandle of interrupt controller and u32 of count defined by
>>    #interrupt-cells of the controller).
>>
>> We probably want to define allowed range of values for given property, be
>> it contiguous or enumerated.
>>
>> As for subnodes, I think we need to define following constraints:
>>  - node name (or node name format, e.g. regex),
>>  - optional or not,
>>  - how many nodes of this type can be present (one, limited, unlimited),
>>  - recursively define binding for such node type.
>>
>> We probably also want human readable descriptions for all properties and
>> subnodes, so a textual documentation (like the one currently available)
>> could be generated from schemas.
>>
>> c) What about generic bindings? (e.g. for subsystems like pinctrl or
>> regulators)
>>
>> This is where things get more interesting. Looks like we need some kind of
>> inheritance for bindings or binding templates. Templates sound more
>> appropriate here, because most of the generic bindings do not fully
>> conform to what I defined as binding and need device-specific parameters
>> to become so.
>>
>> Let's consider first example taken from regulator subsystem.
>>
>>       device {
>>               compatible = "foo,mydevice";
>>               /* ... */
>>               core-supply = <&regulator_a>;
>>               io-supply = <&regulator_b>;
>>               /* ... */
>>       };
>>
>> Bindings of regulator subsystem define the way of regulator lookup to be
>> based on property matching following definition:
>>
>>       #define REGULATOR(name) name ## _supply = <&phandle>
>>
>> As you can see, the binding is parametrized, i.e. part of it is defined
>> globally, but part is device-specific. Similarly for pinctrl subsystem:
>>
>>       device {
>>               compatible = "foo,mydevice";
>>               /* ... */
>>               pinctrl-names = "state0", "state1";
>>               pinctrl-0 = <&phandle>...;
>>               pinctrl-1 = <&phandle>...;
>>               /* ... */
>>       };
>>
>> This binding is now parametrized in a more complex way:
>>
>>       #define PINCTRL(name0, name1, ..., nameN) \
>>               pinctrl-names = name0, name1, ..., nameN; \
>>               pinctrl-0 = <&phandle>...; \
>>               pinctrl-1 = <&phandle>...; \
>>               ... \
>>               pinctrl-N = <&phandle>...;
>>
>> We need to have a way to describe this kind of inheritance, if we don't
>> want to respecify generic attributes in all device bindings using them.
>>
>> d) When should the validation happen and what should handle it?
>>
>> In my opinion, similarly to compilation of board files, validation should
>> be happening at dts compile time, to show any warnings or errors as early
>> as possible.
>>
>> Whether this should be integrated into dtc or rather handled by external
>> tool is another question. Since we are already processing device tree
>> sources in dtc, it might be reasonable to reuse its dts parsing
>> infrastructure and add validation there, especially that dtc is supposed
>> to already contain some infrastructure for doing checks on device tree as
>> well. Nothing stops us from running validation on already compiled dtbs,
>> though, using an extra tool.
>>
>> e) What format should be used for Device Tree schema?
>>
>> This is a non-trivial problem. Key criteria I can think of are as follows:
>>  - the whole set of information established above must be representable,
>>  - human-readable, easy to create and edit (extend), preferably similar to
>>    something already existing, so could be easily learnt,
>>  - something that can be integrated with dtc with reasonable amount of
>>    work or can reuse a lot (if not all) of already existing parsing code.
>>
>> Okay, this should be enough to have some discussion. I will post a
>> follow-up with my proposal of schema format to separate general discussion
>> from discussion about the proposal, but this will happen tomorrow, as now
>> it's time to get some sleep.
>
> Finally I didn't manage to post it yet, but this might be better, as there
> have been a lot of interesting points in the discussion, which I'm now taking
> into consideration, while writing a sample schema.
>
> Best regards,
> Tomasz
>
>> For now please think about the points above and feel free to correct
>> anything wrong or suggest what else should be taken into consideration
>> for DT schemas. Let the discussion start.
>>
>> Best regards,
>> Tomasz



-- 
Jon Smirl
jonsmirl at gmail.com
