From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 25 Jun 2012 17:09:56 -0600
Subject: [PATCH 1/3] ARM: dt: tegra: seaboard: add regulators
In-Reply-To: <20120625222646.GB30406@opensource.wolfsonmicro.com>
References: <1340406842-27135-1-git-send-email-swarren@wwwdotorg.org>
 <4FE80413.6070001@nvidia.com> <4FE87FE3.1080608@wwwdotorg.org>
 <4FE882A5.3080504@nvidia.com>
 <20120625222646.GB30406@opensource.wolfsonmicro.com>
Message-ID: <4FE8EFC4.3090509@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/25/2012 04:26 PM, Mark Brown wrote:
> On Mon, Jun 25, 2012 at 08:54:21PM +0530, Laxman Dewangan wrote:
> 
>> I had detailed discussion with Mark on  this support and as per
>> him (based on my understanding), the input to different regulator
>> is from the pin of the chips and so the name should be the 
>> <pin-name>-supply which should be part of chip-dt binding, not
>> to the particular rail.
> 
> More specifically, all the supplies for a device (including those
> that happen to be inputs for regulators) should be specified in
> exactly the same fashion.  This makes the binding more regular and
> means that users can just go through the schematic adding the
> mappings without worrying about what what the supply happens to
> be.

Just making sure I parsed that right. I think what you're saying is
that the device itself should represent its input pins, e.g.:

tps6586x {
    vin-ldo01-supply = <&some_regulator>;
    vin-ldo23-supply = <...>;
    vin-ldo4-supply = <...>;
    vin-ldo678-supply = <...>;
    vin-ldo9-supply = <...>;

    regulators {
        regulator at 0 {
            regulator-compatible = "ldo0";
            ...
        };
        regulator at 1 {
            regulator-compatible = "ldo1";
            ...
        };
    };
};

(and then the driver internally uses the *-supply to set up the
parents of each of its own regulators)

... rather than each regulator specifying its parent, which might
result in some duplication, since in this case both ldo0/1 are
supplied from the same input pin:

tps6586x {
    regulators {
        regulator at 0 {
            regulator-compatible = "ldo0";
            vin-supply = <&some_regulator>;
            ...
        };
        regulator at 1 {
            regulator-compatible = "ldo1";
            vin-supply = <&some_regulator>;
            ...
        };
    };
};
