From: frowand.list@gmail.com (Frank Rowand)
Date: Thu, 19 Mar 2015 12:01:42 -0700
Subject: [patch 2/7] dt: dtb version: document chosen/dtb-info node binding
In-Reply-To: <20150319184139.GG8656@n2100.arm.linux.org.uk>
References: <550A42AC.8060104@gmail.com> <550A4382.4030209@gmail.com>
 <CAL_Jsq+sPkZtreQ0sp8KXpkUVpFy=Yh9dr249u8uyoa8yksjmg@mail.gmail.com>
 <20150319184139.GG8656@n2100.arm.linux.org.uk>
Message-ID: <550B1D16.7000108@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3/19/2015 11:41 AM, Russell King - ARM Linux wrote:
> On Thu, Mar 19, 2015 at 08:23:29AM -0500, Rob Herring wrote:
>> On Wed, Mar 18, 2015 at 10:33 PM, Frank Rowand <frowand.list@gmail.com> wrote:
>>> +version
>>> +       The version of the DTB.  This is analagous to the linux kernel version.
>>> +
>>> +       This is a format free field intended for human consumption.  User space
>>> +       programs should not have any expections about this property.
>>> +
>>> +       The DTB number in this property is incremented each time a make that
>>> +       creates one or more DTBs is invoked.  If the make creates multiple
>>> +       DTBs then this number is only incremented once.
>>> +
>>> +       The DTB number is stored in file .version_dtb.
>>> +
>>> +version-linux
>>> +       The version of the linux kernel most recently built in the source
>>> +       control system that contains the source used to build the DTB.
>>> +
>>> +       The linux kernel version number is not incremented for a make that
>>> +       creates a DTB.
>>> +
>>> +dtb-path
>>> +       The build directory relative path of the DTB.
>>> +
>>> +dts-path
>>> +       The absolute path of the .dts file compiled to create the DTB.
>>
>> So these become an ABI and we can never change the directory structure?
>>
>> The problem with informational fields is someone, somewhere will rely
>> on them and then we are stuck with them. Look at /proc/cpuinfo.
> 
> There's a bigger problem: including the Linux kernel specific version
> means that we will _never_ be able to move them out of the kernel.

As I failed to properly document, but have said will be in the next
version, the dtb-info node and all of the properties are optional.

As I replied to Mark, I will change version-linux to a more generic
name and meaning in the next version.  The property could be missing,
it could be about BSD, it could be about uboot.  Whatever.

> 
> Moreover, what it means is that people can then write code to test
> what the dtb version is, and we'll end up with the dtb version being
> tested to determine various features.

What???  Why would we ever accept code that tested the dtb version
instead of the compatible strings and properties in device nodes?
The dtb version is a meaningless number just like the kernel version
number in /proc/version is a meaningless number.  It starts at 1 (and
can be reset to 1 anytime the person controlling the build environment
chooses to for any random reason).  The dtb version number only makes
sense in a local context to check which build of an object actually
got onto the target.

I could be creating some confusion here though.  The dtb version string
also includes the current commit of the source code repository, in
exactly the same manner as the kernel version string does.

> 
> Since the design goal of DTB is to describe the hardware, including
> the Linux kernel version is totally against that: the Linux kernel
> version should be totally irrelevant.  What's more relevant would be
> a _hardware_ version field, but even that's questionable...
> 
> And yes, you are right - anything like this which we add immediately
> becames a user ABI which becomes *very* difficult to change later, so
> in order to accept anything like this, we have to be absolutely sure
> that this is something we really really really really want to do.  Let
> me put it another way: once this is accepted, it will probably be
> impossible to ever change it.

Would it be more palatable if including the dtb-info node was conditional
on some debug config option?


> 
> ... just like Bogomips in /proc/cpuinfo.
> 
