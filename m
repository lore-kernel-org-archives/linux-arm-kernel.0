From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Sat, 19 Jul 2014 20:16:36 +0530
Subject: [RFC] cpufreq: Add bindings for CPU clock sharing topology
In-Reply-To: <CAOesGMhuNzVtUkaUjF+JjNgHcgf08WiM0DG-kzwtcyUxkK_zow@mail.gmail.com>
References: <7e097b71342c9f5f63b07ff2e135eb7beb626aab.1405661369.git.viresh.kumar@linaro.org>
 <CAOesGMhTkTEXp99gpU8cZBwYmiXpsySG5zMn6oSyo_Mf5PAiUg@mail.gmail.com>
 <CAKohpo=MmoALOHg-=7cf0jm=OJO57TWQZQXqkRwhRwU-DGPMmA@mail.gmail.com>
 <CAOesGMhuNzVtUkaUjF+JjNgHcgf08WiM0DG-kzwtcyUxkK_zow@mail.gmail.com>
Message-ID: <CAKohpokLqrydV3b=innvOWrW9ijXtZwPKdT5Ew65cjMxsY2Mvw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19 July 2014 03:22, Olof Johansson <olof@lixom.net> wrote:
> What is the current API that is being broken, in your opinion?

So, currently the nodes doesn't have any such property. And drivers
consider all of them as sharing clocks, for eg: cpufreq-cpu0.

Now, if we use those older DT's after the new changes, drivers would
consider CPUs as having separate clocks. And that would be opposite
of what currently happens.

Not sure if this counts as broken.

>> But if that isn't the case, the bindings are very simple & clear to handle.
>> Diff for new bindings:
>
> It's somewhat confusing to see a diff to the patch instead of a new
> version. It seems to remove the cpu 0 entry now?

Not really, I removed an unwanted example. This is how it looks:



* Generic CPUFreq clock bindings

Clock lines may or may not be shared among different CPUs on a platform.

Possible configurations:
1.) All CPUs share a single clock line
2.) All CPUs have independent clock lines
3.) CPUs within a group/cluster share clock line but each group/cluster have a
    separate line for itself

Optional Properties:
- clock-master: Contains phandle of the master cpu controlling clocks.

  Ideally there is nothing like a "master" CPU as any CPU can play with DVFS
  settings. But we have to choose one cpu out of a group, so that others can
  point to it.

  If there is no "clock-master" property for a cpu node, it is considered as
  master. It may or may not have other slave CPUs pointing towards it.

Examples:
1.) All CPUs share a single clock line

cpus {
        #address-cells = <1>;
        #size-cells = <0>;

        cpu0: cpu at 0 {
                compatible = "arm,cortex-a15";
                reg = <0>;
                next-level-cache = <&L2>;
                operating-points = <
                        /* kHz    uV */
                        792000  1100000
                        396000  950000
                        198000  850000
                >;
                clock-latency = <61036>; /* two CLK32 periods */
        };

        cpu1: cpu at 1 {
                compatible = "arm,cortex-a15";
                reg = <1>;
                next-level-cache = <&L2>;
                clock-master = <&cpu0>;
        };
};

2.) All CPUs have independent clock lines
cpus {
        #address-cells = <1>;
        #size-cells = <0>;

        cpu0: cpu at 0 {
                compatible = "arm,cortex-a15";
                reg = <0>;
                next-level-cache = <&L2>;
                operating-points = <
                        /* kHz    uV */
                        792000  1100000
                        396000  950000
                        198000  850000
                >;
                clock-latency = <61036>; /* two CLK32 periods */
        };

        cpu1: cpu at 1 {
                compatible = "arm,cortex-a15";
                reg = <1>;
                next-level-cache = <&L2>;
                operating-points = <
                        /* kHz    uV */
                        792000  1100000
                        396000  950000
                        198000  850000
                >;
                clock-latency = <61036>; /* two CLK32 periods */
        };
};

3.) CPUs within a group/cluster share single clock line but each group/cluster
have a separate line for itself

cpus {
        #address-cells = <1>;
        #size-cells = <0>;

        cpu0: cpu at 0 {
                compatible = "arm,cortex-a15";
                reg = <0>;
                next-level-cache = <&L2>;
                operating-points = <
                        /* kHz    uV */
                        792000  1100000
                        396000  950000
                        198000  850000
                >;
                clock-latency = <61036>; /* two CLK32 periods */
        };

        cpu1: cpu at 1 {
                compatible = "arm,cortex-a15";
                reg = <1>;
                next-level-cache = <&L2>;
                clock-master = <&cpu0>;
        };

        cpu2: cpu at 100 {
                compatible = "arm,cortex-a7";
                reg = <100>;
                next-level-cache = <&L2>;
                operating-points = <
                        /* kHz    uV */
                        792000  950000
                        396000  750000
                        198000  450000
                >;
                clock-latency = <61036>; /* two CLK32 periods */
        };

        cpu3: cpu at 101 {
                compatible = "arm,cortex-a7";
                reg = <101>;
                next-level-cache = <&L2>;
                clock-master = <&cpu2>;
        };
};
