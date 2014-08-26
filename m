From: holler@ahsoftware.de (Alexander Holler)
Date: Tue, 26 Aug 2014 13:01:29 +0200
Subject: [RFC PATCH 0/9] dt: dependencies (for deterministic driver
 initialization order based on the DT)
In-Reply-To: <53FC6513.5040800@ahsoftware.de>
References: <20140514141914.446F7C4153D@trevor.secretlab.ca>
 <20140821140211.GD19293@ulmo.nvidia.com> <53F64624.5000403@ahsoftware.de>
 <20140822131919.GX21734@leverpostej> <20140825093931.GB2399@ulmo>
 <E1XLu15-0002DP-6o@jdl.com> <20140825133714.GH4163@ulmo.nvidia.com>
 <20140826084208.AE5F0C40989@trevor.secretlab.ca>
 <20140826084922.GG17263@ulmo> <53FC566C.30904@ahsoftware.de>
 <20140826102503.GC31124@ulmo> <53FC6513.5040800@ahsoftware.de>
Message-ID: <53FC6909.9000704@ahsoftware.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 26.08.2014 12:44, schrieb Alexander Holler:
> Am 26.08.2014 12:25, schrieb Thierry Reding:
>> On Tue, Aug 26, 2014 at 11:42:04AM +0200, Alexander Holler wrote:
>
>>> You need either the type information in the DTB (that's why I've add
>>> those
>>> "dependencies" to identify phandles), or you need to know every
>>> binding (at
>>> "dependency-resolve-time" to identify phandles. The latter is
>>> impracticable
>>> to implement in a generic way (for use with every possible binding).
>>
>> Like I already mentioned, this could be done in drivers who contain that
>> information already anyway. Or parts of it could be done in subsystem-
>> specific callbacks where a generic binding is available.
>
> That would end up with almost the same ugly driver-based workarounds as
> now. It's much better if a driver author only has to define it's
> prerequisits (in form of dependencies in the dts) and could be sure the
> driver will only be probed if those are met, than to do that stuff based
> on a subsystem or even driver level.
>
> If you add dependency-information to drivers, you have two problems:
>
> - How do you get these information from the driver (remember, currently
> there is only one initial call, a initcall which might do almost anything)
>
> - These information might become outdated and you would have to change
> all drivers. E.g. if the name of a dependency (driver) changes it
> wouldn't be done with changing the dts (maybe plural), but you would
> have to change the source of all dependant drivers too.

And after having sorted my brain:

A driver depends on a binding (and its API), but not on explicit named 
other drivers. So trying it (again) on driver level is doomed to fail.

Alexander Holler
