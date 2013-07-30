From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 30 Jul 2013 16:26:15 -0600
Subject: Defining schemas for Device Tree
In-Reply-To: <3852729.INDSeEDz7b@thinkpad>
References: <2469263.vMN09Q7Tzi@flatron> <3852729.INDSeEDz7b@thinkpad>
Message-ID: <51F83D87.2010707@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/30/2013 04:16 PM, Tomasz Figa wrote:
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

I think one of the use-cases that having schema validation was asked to
cover was the case of a typo in a property name leading to that property
having no effect. This could only be caught by the validation tool if it
warned (or worse) about unknown properties.
