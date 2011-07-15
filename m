From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 15 Jul 2011 07:27:03 +0100
Subject: [PATCH 2/3] mach-ux500: export System-on-Chip information via
	sysfs
In-Reply-To: <4E1F2696.3010608@codeaurora.org>
References: <1310476090-9807-1-git-send-email-lee.jones@linaro.org>	<4E1DCA83.7010204@codeaurora.org>
	<20110713203226.GA23055@suse.de> <201107132251.48606.arnd@arndb.de>
	<4E1F2696.3010608@codeaurora.org>
Message-ID: <4E1FDDB7.9070900@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14/07/11 18:25, Saravana Kannan wrote:
> On 07/13/2011 01:51 PM, Arnd Bergmann wrote:
>> On Wednesday 13 July 2011 22:32:26 Greg KH wrote:
>>> On Wed, Jul 13, 2011 at 09:40:35AM -0700, Saravana Kannan wrote:
>>>> On 07/13/2011 12:55 AM, Lee Jones wrote:
>>>>> On 12/07/11 17:29, Saravana Kannan wrote:
>>>>> I initially had it all as part of soc_device_register, but Arnd
>>>>> told me
>>>>> to remove it in this patch-set.
>>>>>
>>>>> See here:
>>>>>
>>>>> On 17/04/11 19:36, Arnd Bergmann wrote:
>>>>>> For the nonstandard attributes, I would recommend having the
>>>>>> individual
>>>>>> drivers call device_create_file, in order to discourage the use of
>>>>>> device specific attribute names.
>>>>
>>>> Arnd,
>>>>
>>>> I don't think forcing individual driver to call device_create_file()
>>>> is really going to be much of a discouragement.
>>>
>>> Yes it is as calling that is broken and wrong and userspace will race
>>> with the kernel and bad things will happen on the wrong phase of the
>>> moon.
>>>
>>> But again, I never saw the original series to explain why...
> 
> Greg,
> 
> Your wording was a bit confusing for me (sorry), but it appears that you
> are disagreeing with me. Assuming that to be the case, how will moving a
> couple of lines of code (calls to device_create_file()) from a caller
> function A into caller function B make any functional difference if the
> order of the calls are maintained? The calls to device_create_file()
> will still be done as part of the same call flow/execution flow. I'm
> just asking for code refactoring to avoid repeating the code multiple
> times.

I believe it is Arnd that's disagreeing with you. For his full
description as to why he thought it was a bad idea to allow users to
_easily_ add nodes, see my first attempts at this patch.

I initially had this:

+struct device_attribute soc_one_attrs[] = {
+	__ATTR(machine,  S_IRUGO, ux500_get_machine,  NULL),
+	__ATTR(family,   S_IRUGO, ux500_get_family,   NULL),
+	__ATTR(soc_id,   S_IRUGO, ux500_get_soc_id,   NULL),
+	__ATTR(revision, S_IRUGO, ux500_get_revision, NULL),
+	__ATTR(process,  S_IRUGO, ux500_get_process,  NULL),
+	__ATTR_NULL,
+};
+
+struct device_attribute *each_soc_attrs[] = {
+	soc_one_attrs,
+	NULL,
+};
+
+static int __init ux500_soc_sysfs_init(void)
+{
+	return soc_device_register(&parent_soc, each_soc_attrs
+                                  ARRAY_SIZE(each_soc_attrs));
+}

Which I loved. It was neat and easy to read. However, Arnd felt that it
would be far too easy for SoC vendors/hackers to add nodes willy-nilly,
which he wanted to prevent. Hence the request for change.

Kind regards,
Lee

>> This is about attributes to the main device that acts as a parent for all
>> devices on the SoC, so there is no user space at the time.
>>
>> IIRC, the original patch was documenting a set of standard attributes and
>> letting the SoC specific driver pass a set of static attributes in the
>> hope that they do whatever is documented.
>>
>> In one of my review comments, I asked this to be changed to pass a data
>> structure with the actual contents of those attributes and to make
>> the implementation common to the soc independent code, in order to
>> reduce the amount of code needed in each soc implementation, to enforce
>> consistent behavior, and to make it more obvious (and painful) when an
>> soc implementation adds a nonstandard attribute.
>>
>> It seems the final outcome was to have a data structure of function
>> pointers to get the attribute contents, which is less nice but still
>> acceptable IMHO.
>>
>>     Arnd
> 


-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
M: +44 77 88 633 515
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
